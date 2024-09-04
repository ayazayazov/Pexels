//
//  HomeVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 17.08.24.
//

import UIKit

class HomeVC: UIViewController, UISearchBarDelegate {
    var MinusIdealHeightForCell: CGFloat = 0
    
    private let viewModel = HomeVM()
    
    
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
        //        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    
    
    
    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 52
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HomeFeedCell.self, forCellWithReuseIdentifier: "cell")
//        cv.register(HomeFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        headerSetup()
        feedSetup()
        configureViewModel()
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
    
    func configureViewModel() {
        viewModel.getCuratedPhotos()
        viewModel.error = { errorMessage in
            print("Error(HomeVC44): \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
        }
        viewModel.success = {
            self.feed.reloadData()
        }
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if view.frame.height >= 932 {
//            MinusIdealHeightForCell = 220
//        } else if view.frame.height >= 852 {
//            MinusIdealHeightForCell = 198
//        } else if view.frame.height >= 812 {
//            MinusIdealHeightForCell = 184
//        } else if view.frame.height >= 667 {
//            MinusIdealHeightForCell = 40
//        }
//        return CGSize(width: view.frame.width, height: view.frame.height - MinusIdealHeightForCell)
        
//        height 638px for iphone 15
        return CGSize(width: view.frame.width, height: 656)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller =  PhotoDetailVC()
        controller.photoID = viewModel.items[indexPath.item].id
        navigationController?.show(controller, sender: nil)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier, for: indexPath) as! HomeFeedHeader
//        header.configure()
//        return header
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 88)
//    }
}
