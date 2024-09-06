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
  
    var currentData: [Any] = []
    
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
    
    private let segment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Photos", "Videos"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 52
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HomeFeedCell.self, forCellWithReuseIdentifier: "cell")
//        cv.register(HomeFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        configureUI()
        
        configureViewModel()
        configureVideoViewModel()
        
        feed.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }

    private func headerSetup() {
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
        }
        viewModel.successVIDEO = {
            self.videoURL = self.viewModel.videoItems[0].videoFiles?[2].link ?? ""
            print("video link -> ", self.videoURL)
        }
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
    }
    
    @objc func segmentChanged() {
            switch segment.selectedSegmentIndex {
            case 0:
//                currentData: [PhotoData] = []
                extensionSegmentIndex = 0
                currentData = viewModel.items
                print("SEGMENT INDEX 0 CURRENT DATA", currentData)
            case 1:
//                currentData: [VideoElement] = []
                extensionSegmentIndex = 1
                currentData = viewModel.videoItems
                print("SEGMENT INDEX 1 CURRENT DATA", currentData)
            default:
                currentData = [viewModel.items]
            }
            feed.reloadData()
        }
    
    func startVideo() {
        let url = URL(string: videoURL)
        player = AVPlayer(url: url!)
        avpController.player = player
        player.play()
        present(avpController, animated: true) {
            self.avpController.player?.play()
        }
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = viewModel.items[indexPath.item].width
//        let height = viewModel.items[indexPath.item].height
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imageRation.calc(width: width, height: height)  + 96)
        if extensionSegmentIndex == 0 {
            let width = viewModel.items[indexPath.item].width
            let height = viewModel.items[indexPath.item].height
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imageRation.calc(width: width, height: height)  + 96)
        } else {
//            let width = viewModel.videoItems[indexPath.item].videoPictures
            return CGSize(width: collectionView.frame.width, height: 790)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.items.count
        if extensionSegmentIndex == 0 {
            viewModel.items.count
        } else {
            currentData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
        if extensionSegmentIndex == 0 {
            cell.configure(data: viewModel.items[indexPath.item])
        } else {
            cell.configure(data: currentData[indexPath.item] as! HomeFeedCellProtocol)
        }
//        cell.configure(data: currentData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if extensionSegmentIndex == 0 {
            let controller =  PhotoDetailVC()
            controller.photoID = viewModel.items[indexPath.item].id
            navigationController?.show(controller, sender: nil)
        } else {
            startVideo()
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        viewModel.pagination(index: indexPath.item)
//    }

}

//extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = viewModel.items[indexPath.item].width
//        let height = viewModel.items[indexPath.item].height
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imageRation.calc(width: width, height: height)  + 96)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.items.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
//        cell.configure(data: viewModel.items[indexPath.item])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller =  PhotoDetailVC()
//        controller.photoID = viewModel.items[indexPath.item].id
//        navigationController?.show(controller, sender: nil)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        viewModel.pagination(index: indexPath.item)
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier, for: indexPath) as! HomeFeedHeader
////        header.configure()
////        return header
////    }
//    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
////        return CGSize(width: view.frame.width, height: 88)
////    }
//}
