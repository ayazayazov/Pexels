//
//  HomeVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 17.08.24.
//

import UIKit

class HomeVC: UIViewController {
    private let viewModel = HomeVM()
    
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
        layout.minimumLineSpacing = 60
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HomeFeedCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(feed)
        view.addSubview(segment)
        segmentSetup()
        feedSetup()
        configureViewModel()
    }
    
    private func segmentSetup() {
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            segment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    private func feedSetup() {
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            feed.topAnchor.constraint(equalTo: segment.bottomAnchor),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeFeedCell
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
}
