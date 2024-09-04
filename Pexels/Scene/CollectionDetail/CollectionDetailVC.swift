//
//  CollectionDetailVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import UIKit

class CollectionDetailVC: UIViewController {
    
    private let viewModel = CollectionDetailVM()
    
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
//        cv.register(HomeFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier)
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
        configureViewModel(page: 1, perPage: 5, collectionID: collectionID ?? "0ds0rcv")
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func configureViewModel(page: Int?, perPage: Int?, collectionID: String) {
        viewModel.getCollectionMedia(page: page, perPage: perPage, collectionID: collectionID)
        viewModel.error = { errorMessage in
            print("Error(HomeVC44): \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
        }
        viewModel.success = {
            self.feed.reloadData()
        }
    }
    
    private func setupView() {
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            feed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

}


extension CollectionDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionDetailCell
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
