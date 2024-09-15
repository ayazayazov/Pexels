//
//  HomeVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 17.08.24.
//

import UIKit
import AVFoundation
import AVKit
import FirebaseFirestoreInternal

class HomeVC: UIViewController, UITextFieldDelegate {
    
    
    private let viewModel = HomeVM()
    private let favoritesVC = FavoritesVC()
    
    var searchedPhotosItems = [PhotoData]()
    
    private var videoURL: String = ""
    var player : AVPlayer!
    var avpController = AVPlayerViewController()
    
    var extensionSegmentIndex = 0
    
    private let db = Firestore.firestore()
    
    //    private var items = [SavedPhotos]()
    
    private let imageRation = ImageRationCalc()
    private let refreshControl = UIRefreshControl()
    
    private let searchBarView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .systemGray6
        iv.layer.cornerRadius = 10
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
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
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        configureUI()
        configureViewModel()
        configureVideoViewModel()
        
        //        getUsers()
        //        configureSavedPhotosViewModel()
        feed.reloadData()
//        initializeHideKeyboard()
    }
    
    private func configureUI() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        feed.refreshControl = refreshControl
        view.addSubview(searchBarView)
        searchBarView.addSubview(searchBar)
        searchBar.delegate = self
        view.addSubview(searchButton)
        view.addSubview(segment)
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBarView.rightAnchor.constraint(equalTo: searchButton.leftAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 40),
            
            searchBar.topAnchor.constraint(equalTo: searchBarView.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: searchBarView.leftAnchor, constant: 8),
            searchBar.rightAnchor.constraint(equalTo: searchBarView.rightAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
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
    
        
        func configureSavedPhotosViewModel() {
            viewModel.getSavedPhotos()
            viewModel.errorSavedPhotos = { errorMessage in
                self.showAlertController(title: "error", message: errorMessage)
            }
            viewModel.successSavedPhotos = {
                //            print("DIDLOAD VIEW-MODEL ITEMS>>>>>", self.viewModel.savedPhotosItems)
                //            self.items.append(contentsOf: self.viewModel.savedPhotosItems)
            }
        }
        
        @objc func pullToRefresh() {
            if extensionSegmentIndex == 0 {
                viewModel.reset()
            } else {
                viewModel.videoReset()
            }
        }
        
        @objc func searchButtonPressed() {
            if let text = searchBar.text {
                let controller = SearchResultsVC()
                controller.searchBarText = text
                controller.hidesBottomBarWhenPushed = true
                navigationController?.show(controller, sender: nil)
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
        
        //    func getUsers() {
        //        items.removeAll()
        //        db.collection("users/ayazayazov00@gmail.com/savedPhotos").getDocuments { snapshot, error in
        //            if let error {
        //                print("error: \(error.localizedDescription)")
        //            } else if let snapshot {
        //                for document in snapshot.documents {
        //                    let dict = document.data()
        //                    if let jsonData = try? JSONSerialization.data(withJSONObject: dict) {
        //                        do {
        //                            var item = try JSONDecoder().decode(SavedPhotos.self, from: jsonData)
        //                            item.documentID = document.documentID
        //                            self.items.append(item)
        //                        } catch {
        //                            print("error: \(error.localizedDescription)")
        //                        }
        //                    }
        //                }
        //                //                self.feed.reloadData()
        //            }
        //        }
        //    }
        
        @objc func saveAction(sender: UIButton) {
            if extensionSegmentIndex == 0 {
                print("Photo \(sender.tag) Saved")
                let savedPhotoData = [
                    "photoID": viewModel.items[sender.tag].id,
                    "photoLink": "\(viewModel.items[sender.tag].src?.tiny ?? "")",
                    "photographerName": "\(viewModel.items[sender.tag].photographerName)",
                    "documentID": ""
                ] as [String : Any]
                db.collection("users/ayazayazov00@gmail.com/savedPhotos").addDocument(data: savedPhotoData)
                
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
                let width = viewModel.videoItems[indexPath.item].width
                let height = viewModel.videoItems[indexPath.item].height
                if width > height {
                    return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.525 + 96)
                } else {
                    return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 1.904 + 96)
                }
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
                cell.playImage.isHidden = true
            } else {
                cell.configure(data: viewModel.videoItems[indexPath.item])
                cell.playImage.isHidden = false
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


//extension HomeVC {
//    func initializeHideKeyboard(){
//        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(dismissMyKeyboard))
//        //Add this tap gesture recognizer to the parent view
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dismissMyKeyboard(){
//        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
//        //In short- Dismiss the active keyboard.
//        view.endEditing(true)
//    }
//}
