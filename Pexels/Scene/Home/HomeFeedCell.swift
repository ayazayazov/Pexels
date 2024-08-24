//
//  HomeFeedCell.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import UIKit

class HomeFeedCell: UICollectionViewCell {
    private var cellImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let photographerUsername: UILabel = {
        let il = UILabel()
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
    
    
    func configure(with imageName: String, with title: String) {
        cellImage.image = UIImage(named: imageName)
        photographerUsername.text = title
    }
    
    
    private func setupView() {
        addSubview(cellImage)
        addSubview(photographerUsername)
        NSLayoutConstraint.activate([
            photographerUsername.topAnchor.constraint(equalTo: topAnchor),
            photographerUsername.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            photographerUsername.rightAnchor.constraint(equalTo: rightAnchor),
            
            cellImage.topAnchor.constraint(equalTo: photographerUsername.bottomAnchor),
            cellImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
    }
}
