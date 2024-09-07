//
//  HomeVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 17.08.24.
//

import UIKit
import AVFoundation
import AVKit

class HomeVC: UIViewController, UISearchBarDelegate {
    private let viewModel = HomeVM()
    
    private var videoURL: String = ""
    var player : AVPlayer!
    var avpController = AVPlayerViewController()
    var extensionSegmentIndex = 0
    
    private let imageRation = ImageRationCalc()
    private let refreshControl = UIRefreshControl()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.backgroundImage = UIImage()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
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
        view.backgroundColor = .white
        configureUI()
        configureViewModel()
        configureVideoViewModel()
        feed.reloadData()
    }

    private func headerSetup() {
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        searchBar.delegate = self
        view.addSubview(searchBar)
        view.addSubview(segment)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            segment.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            segment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            segment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            segment.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func feedSetup() {
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            feed.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 8),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func configureUI() {
        headerSetup()
        feedSetup()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        feed.refreshControl = refreshControl
    }
    
    func configureViewModel() {
        viewModel.getCuratedPhotos()
        viewModel.error = { errorMessage in
            print("Error(HomeVC44): \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
            self.refreshControl.endRefreshing()
        }
        viewModel.success = {
            self.refreshControl.endRefreshing()
            self.feed.reloadData()
        }
    }
    
    func configureVideoViewModel() {
        viewModel.getPopularVideos()
        viewModel.errorVIDEO = { errorMessage in
            print("Error(HomeVC44): \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
            self.refreshControl.endRefreshing()
        }
        viewModel.successVIDEO = {
            self.refreshControl.endRefreshing()
            self.feed.reloadData()
        }
    }
    
    @objc func pullToRefresh() {
        if extensionSegmentIndex == 0 {
            viewModel.reset()
        } else {
            viewModel.videoReset()
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
    
    @objc func likeAction(sender: UIButton) {
        if extensionSegmentIndex == 0 {
            print("Photo \(sender.tag) Liked")
        } else {
            print("Video \(sender.tag) Liked")
        }
    }
    
    @objc func saveAction(sender: UIButton) {
        if extensionSegmentIndex == 0 {
            print("Photo \(sender.tag) Saved")
        } else {
            print("Video \(sender.tag) Saved")
        }
    }
    
    @objc func downloadAction(sender: UIButton) {
        if extensionSegmentIndex == 0 {
            print("Photo \(sender.tag) Dowloaded")
        } else {
            print("Video \(sender.tag) Dowloaded")
        }
    }
    
    @objc func followAction(sender: UIButton) {
        if extensionSegmentIndex == 0 {
            print("Photo \(sender.tag) User Followed")
        } else {
            print("Video \(sender.tag) User Followed")
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if extensionSegmentIndex == 0 {
            let width = viewModel.items[indexPath.item].width
            let height = viewModel.items[indexPath.item].height
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imageRation.calc(width: width, height: height)  + 96)
        } else {
            return CGSize(width: collectionView.frame.width, height: 800)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if extensionSegmentIndex == 0 {
            viewModel.items.count
        } else {
            viewModel.videoItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
        cell.likeButton.tag = indexPath.item
        cell.bookmarkButton.tag = indexPath.item
        cell.downloadButton.tag = indexPath.item
        cell.followButton.tag = indexPath.item
        if extensionSegmentIndex == 0 {
            cell.configure(data: viewModel.items[indexPath.item])
            cell.likeButton.tag = indexPath.item
        } else {
            cell.configure(data: viewModel.videoItems[indexPath.item])
        }
        cell.likeButton.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
        cell.bookmarkButton.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)
        cell.downloadButton.addTarget(self, action: #selector(downloadAction(sender:)), for: .touchUpInside)
        cell.followButton.addTarget(self, action: #selector(followAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if extensionSegmentIndex == 0 {
            let controller =  PhotoDetailVC()
            controller.photoID = viewModel.items[indexPath.item].id
            controller.hidesBottomBarWhenPushed = true
            navigationController?.show(controller, sender: nil)
        } else {
            let videoURL = viewModel.videoItems[indexPath.item].videoFiles?[2].link ?? ""
            startVideo(videoURL: videoURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if extensionSegmentIndex == 0 {
            viewModel.pagination(index: indexPath.item)
        } else {
            viewModel.videoPagination(index: indexPath.item)
        }
    }
}
