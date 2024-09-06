//
//  FavoritesVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 29/8/24.
//

import UIKit


class FavoritesVC: UIViewController {
    
    private let feedLabel: UILabel = {
        let il = UILabel()
        il.text = "Saved Posts"
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
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewSetup()
        configureViewModel()
    }
    
    func configureViewModel() {
        }

    private func viewSetup() {
        NSLayoutConstraint.activate([
        ])
    }
}
