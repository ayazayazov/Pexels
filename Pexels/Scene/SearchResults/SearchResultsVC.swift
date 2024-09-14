//
//  SearchResultsVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 11/9/24.
//

import UIKit
import AVFoundation
import AVKit

class SearchResultsVC: UIViewController, UITextFieldDelegate {
    
    private let viewModel = HomeVM()
    
    private let imageRation = ImageRationCalc()
    private var videoURL: String = ""
    var player : AVPlayer!
    var avpController = AVPlayerViewController()
    
    var searchBarText: String?
    var extensionSegmentIndex = 0
    
    private let searchBarView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let searchBar: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search for amazing content"
        //        tf.isUserInteractionEnabled = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let backButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        ub.backgroundColor = .systemGray6
        ub.tintColor = .black
        ub.layer.cornerRadius = 10
        ub.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    private let searchButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        ub.backgroundColor = .systemGray6
        ub.tintColor = .black
        ub.layer.cornerRadius = 10
        ub.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    private var segment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Photos", "Videos"])
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 52
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HomeFeedCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configureUI()
        configureSearchedPhotosViewModel(query: searchBarText)
        configureSearchedVideosViewModel(query: searchBarText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureUI() {
        searchBar.text = searchBarText
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
//        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
//        feed.refreshControl = refreshControl
        view.addSubview(searchBarView)
        searchBarView.addSubview(searchBar)
        searchBar.delegate = self
        view.addSubview(backButton)
        view.addSubview(searchButton)
        view.addSubview(segment)
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchBarView.leftAnchor.constraint(equalTo: backButton.rightAnchor),
            searchBarView.rightAnchor.constraint(equalTo: searchButton.leftAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 40),
            
            searchBar.topAnchor.constraint(equalTo: searchBarView.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: searchBarView.leftAnchor, constant: 8),
            searchBar.rightAnchor.constraint(equalTo: searchBarView.rightAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            segment.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 8),
            segment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            segment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            segment.heightAnchor.constraint(equalToConstant: 40),
            
            feed.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 8),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func configureSearchedPhotosViewModel(query: String?) {
        viewModel.getSearchForPhotos(query: query)
        viewModel.errorSearchedPhotos = { errorMessage in
            print("errorSearchedPhotos ->", errorMessage)
            
        }
        viewModel.successSearchedPhotos = {
            self.feed.reloadData()
        }
            
    }
    
    func configureSearchedVideosViewModel(query: String?) {
        viewModel.getsearchForVideos(query: query)
        viewModel.errorSearchedVideos = { errorMessage in
            print("errorSearchedVideos ->", errorMessage)
            
        }
        viewModel.successSearchedVideos = {
            self.feed.reloadData()
        }
            
    }
    
    @objc func searchButtonPressed() {
        if let text = searchBar.text {
            feed.scrollsToTop = true
            viewModel.searchedPhotosItems.removeAll()
            viewModel.searchedVideosItems.removeAll()
            configureSearchedPhotosViewModel(query: text)
            configureSearchedVideosViewModel(query: text)
        }
    }
    
    @objc func segmentChanged() {
        switch segment.selectedSegmentIndex {
        case 0:
            extensionSegmentIndex = 0
        case 1:
            extensionSegmentIndex = 1
        default:
            extensionSegmentIndex = 0
        }
        feed.reloadData()
    }
    
    func startVideo(videoURL: String) {
        let url = URL(string: videoURL)
        player = AVPlayer(url: url!)
        avpController.player = player
        player.play()
        present(avpController, animated: true) {
            self.avpController.player?.play()
        }
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchResultsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if extensionSegmentIndex == 0 {
            let width = viewModel.searchedPhotosItems[indexPath.item].width
            let height = viewModel.searchedPhotosItems[indexPath.item].height
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imageRation.calc(width: width, height: height)  + 96)
        } else {
            let width = viewModel.searchedVideosItems[indexPath.item].width
            let height = viewModel.searchedVideosItems[indexPath.item].height
            if width > height {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.525 + 96)
            } else {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 1.904 + 96)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if extensionSegmentIndex == 0 {
            viewModel.searchedPhotosItems.count
        } else {
            viewModel.searchedVideosItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
        cell.likeButton.tag = indexPath.item
        cell.bookmarkButton.tag = indexPath.item
        cell.downloadButton.tag = indexPath.item
        cell.followButton.tag = indexPath.item
        if extensionSegmentIndex == 0 {
            cell.configure(data: viewModel.searchedPhotosItems[indexPath.item])
            cell.likeButton.tag = indexPath.item
            cell.playImage.isHidden = true
        } else {
            cell.configure(data: viewModel.searchedVideosItems[indexPath.item])
            cell.playImage.isHidden = false
        }
//        cell.likeButton.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
//        cell.bookmarkButton.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)
//        cell.downloadButton.addTarget(self, action: #selector(downloadAction(sender:)), for: .touchUpInside)
//        cell.followButton.addTarget(self, action: #selector(followAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if extensionSegmentIndex == 0 {
            let controller =  PhotoDetailVC()
            controller.photoID = viewModel.searchedPhotosItems[indexPath.item].id
            controller.hidesBottomBarWhenPushed = true
            navigationController?.show(controller, sender: nil)
        } else {
            let videoURL = viewModel.searchedVideosItems[indexPath.item].videoFiles?[2].link ?? ""
            startVideo(videoURL: videoURL)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if extensionSegmentIndex == 0 {
//            viewModel.pagination(index: indexPath.item)
//        } else {
//            viewModel.videoPagination(index: indexPath.item)
//        }
//    }
}
