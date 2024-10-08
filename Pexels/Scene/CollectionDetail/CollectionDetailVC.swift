//
//  CollectionDetailVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import UIKit
import AVFoundation
import AVKit

class CollectionDetailVC: UIViewController {
    
    private let viewModel = CollectionDetailVM()
    private let imageRation = ImageRationCalc()
    private let refreshControl = UIRefreshControl()
    
    private var videoURL: String = ""
    var player : AVPlayer!
    var avpController = AVPlayerViewController()
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
    
    var collectionID: String?
    var collectionTitle: String?

    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 52
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionDetailCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = collectionTitle
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        print(collectionID ?? "empty")
        configureViewModel()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureUI() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        feed.refreshControl = refreshControl
        
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            feed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func configureViewModel() {
        viewModel.getCollectionMedia(collectionID: collectionID ?? "")
        viewModel.error = { errorMessage in
            print("Error(CollectionDetailVC72)>>> \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
            self.refreshControl.endRefreshing()
        }
        viewModel.success = {
            self.refreshControl.endRefreshing()
            self.feed.reloadData()
        }
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
    
    @objc func pullToRefresh() {
        viewModel.reset(collectionID: collectionID ?? "")
    }
}

extension CollectionDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let mediaType = viewModel.items[indexPath.item].type
        if mediaType == "Photo" {
            let width = viewModel.items[indexPath.item].width
            let height = viewModel.items[indexPath.item].height
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imageRation.calc(width: width, height: height)  + 96)
        } else {
            let width = viewModel.items[indexPath.item].width
            let height = viewModel.items[indexPath.item].height
            if width > height {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.525 + 96)
            } else {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 1.904 + 96)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionDetailCell
        cell.collectionMediaType = viewModel.items[indexPath.item].type
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller =  PhotoDetailVC()
        let mediaType = viewModel.items[indexPath.item].type
        if mediaType == "Photo" {
            controller.photoID = viewModel.items[indexPath.item].id
            navigationController?.show(controller, sender: nil)
        } else {
            let videoURL = viewModel.items[indexPath.item].videoFiles?[2].link ?? ""
            startVideo(videoURL: videoURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item, collectionID: collectionID ?? "")
    }
}
