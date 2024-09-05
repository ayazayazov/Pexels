//
//  SearchVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 29/8/24.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {
    
    private let viewModel = SearchVM()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.backgroundImage = UIImage()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private let feedLabel: UILabel = {
        let il = UILabel()
        il.text = "Popular Collections"
        il.font = .systemFont(ofSize: 30, weight: .bold)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SearchFeedCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    private func viewSetup() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        view.addSubview(feedLabel)
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            feedLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            feedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            feedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            feed.topAnchor.constraint(equalTo: feedLabel.bottomAnchor, constant: 20),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    func configureViewModel() {
        viewModel.getFeaturedCollections()
        viewModel.error = { errorMessage in
            print("Error(HomeVC44): \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
        }
        viewModel.success = {
            self.feed.reloadData()
        }
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchFeedCell
        cell.configure(data: viewModel.items[indexPath.item])
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller =  CollectionDetailVC()
        controller.collectionID = viewModel.items[indexPath.item].id
        controller.collectionTitle = viewModel.items[indexPath.item].title
        navigationController?.show(controller, sender: nil)
    }
}
