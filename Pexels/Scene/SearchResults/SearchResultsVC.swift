//
//  SearchResultsVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 11/9/24.
//

import UIKit

class SearchResultsVC: UIViewController {
    
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

       
    }
    


}
