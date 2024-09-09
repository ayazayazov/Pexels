//
//  SearchVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 29/8/24.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
    
    private let viewModel = SearchVM()
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
        navigationController?.isNavigationBarHidden = true
        configureUI()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    private func configureUI() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        feed.refreshControl = refreshControl
        view.addSubview(searchBarView)
        searchBarView.addSubview(searchBar)
        searchBar.delegate = self
        view.addSubview(searchButton)
        view.addSubview(feedLabel)
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
            
            feedLabel.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 20),
            feedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            feedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            feed.topAnchor.constraint(equalTo: feedLabel.bottomAnchor, constant: 20),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    func configureViewModel() {
        viewModel.getFeaturedCollections()
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
    
    @objc func pullToRefresh() {
        viewModel.reset()
    }
    
    @objc func searchButtonPressed() {
        print("search btn pressed")
        if let text = searchBar.text {
            print(text)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
