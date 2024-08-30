//
//  HomeFeedCell.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import UIKit

protocol HomeFeedCellProtocol{
    var imageName: String { get }
    var photographerName: String { get }
}

class HomeFeedCell: UICollectionViewCell {
    private let cellImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let photographerUsername: UILabel = {
        let il = UILabel()
        il.font = .systemFont(ofSize: 16, weight: .bold)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    private let followButton: UIButton = {
        let ub = UIButton()
        ub.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        ub.setTitle("Follow", for: .normal)
        ub.setTitleColor(.systemGray, for: .normal)
        ub.layer.borderColor = UIColor.systemGray4.cgColor
        ub.layer.borderWidth = 1
        ub.layer.cornerRadius = 10
        ub.backgroundColor = .systemBackground
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    private let cellTopContainer: UIStackView = {
        let us = UIStackView()
        us.axis = .horizontal
        us.distribution = .fillProportionally
        us.translatesAutoresizingMaskIntoConstraints = false
        return us
    }()
    
    private let likeButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "like-unfilled"), for: .normal)
        ub.tintColor = .black
        ub.backgroundColor = .systemBackground
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    private let bookmarkButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "bookmark-unfilled"), for: .normal)
        ub.tintColor = .black
        ub.backgroundColor = .systemBackground
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    private let downloadButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "download"), for: .normal)
        ub.tintColor = .black
        ub.backgroundColor = .systemBackground
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: HomeFeedCellProtocol) {
        cellImage.loadImage(url: data.imageName)
        photographerUsername.text = data.photographerName
    }
    
    
    private func setupView() {
        cellTopContainer.addArrangedSubview(photographerUsername)
        cellTopContainer.addArrangedSubview(followButton)

        addSubview(cellTopContainer)
        addSubview(cellImage)
        addSubview(likeButton)
        addSubview(bookmarkButton)
        addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            followButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            cellTopContainer.topAnchor.constraint(equalTo: topAnchor),
            cellTopContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            cellTopContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            cellTopContainer.heightAnchor.constraint(equalToConstant: 40),
            
            cellImage.topAnchor.constraint(equalTo: cellTopContainer.bottomAnchor),
            cellImage.leftAnchor.constraint(equalTo: leftAnchor),
            cellImage.rightAnchor.constraint(equalTo: rightAnchor),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likeButton.topAnchor.constraint(equalTo: cellImage.bottomAnchor),
            likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),

            bookmarkButton.topAnchor.constraint(equalTo: cellImage.bottomAnchor),
            bookmarkButton.leftAnchor.constraint(equalTo: likeButton.leftAnchor, constant: 60),
            
            downloadButton.topAnchor.constraint(equalTo: cellImage.bottomAnchor),
            downloadButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
            
        ])
    }
}
