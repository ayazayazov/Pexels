//
//  SearchFeedCell.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 4/9/24.
//

import UIKit

protocol SearchFeedCellProtocol{
    var collectionTitle: String { get }
    var mediaCountLabel: Int { get }
    var photosCountLabel: Int {get}
    var videosCountLabel: Int {get}
}

class SearchFeedCell: UICollectionViewCell {
    
    private let collectionTitle: UILabel = {
        let il = UILabel()
        il.font = .systemFont(ofSize: 22, weight: .semibold)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    private let mediaLabel: UILabel = {
        let il = UILabel()

        il.font = .systemFont(ofSize: 14, weight: .light)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: SearchFeedCellProtocol) {
        collectionTitle.text = data.collectionTitle
        mediaLabel.text = "\(data.photosCountLabel) Photos & \(data.videosCountLabel) Videos | \(data.mediaCountLabel)"
    }
    
    private func setupView() {
        addSubview(collectionTitle)
        addSubview(mediaLabel)
        NSLayoutConstraint.activate([
            collectionTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            collectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionTitle.heightAnchor.constraint(equalToConstant: 28),
            
            mediaLabel.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 12),
            mediaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mediaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mediaLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            mediaLabel.heightAnchor.constraint(equalToConstant: 14),
            
        ])
    }
}
