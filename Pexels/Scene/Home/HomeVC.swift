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
    
    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 52
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HomeFeedCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(HomeFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        feedSetup()
        configureViewModel()
    }
    
    private func feedSetup() {
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            feed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feed.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            feed.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func configureViewModel() {
        viewModel.getPhotos()
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
        if view.frame.height >= 932 {
            MinusIdealHeightForCell = 220
        } else if view.frame.height >= 852 {
            MinusIdealHeightForCell = 198
        } else if view.frame.height >= 812 {
            MinusIdealHeightForCell = 184
        } else if view.frame.height >= 667 {
            MinusIdealHeightForCell = 40
        }
        return CGSize(width: view.frame.width, height: view.frame.height - MinusIdealHeightForCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFeedHeader.identifier, for: indexPath) as! HomeFeedHeader
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 88)
    }
}
