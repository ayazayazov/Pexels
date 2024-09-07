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
    var isLiked = false
    
    private let photographerUsername: UILabel = {
        let il = UILabel()
        il.font = .systemFont(ofSize: 16, weight: .bold)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    let followButton: UIButton = {
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
    
    private let cellImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "like-unfilled"), for: .normal)
        ub.tintColor = .black
        ub.backgroundColor = .systemBackground
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    let bookmarkButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "bookmark-unfilled"), for: .normal)
        ub.tintColor = .black
        ub.backgroundColor = .systemBackground
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    let downloadButton: UIButton = {
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
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.followButton.point(inside: convert(point, to: followButton), with: event) {
            return self.followButton
        }
        if self.likeButton.point(inside: convert(point, to: likeButton), with: event) {
            return self.likeButton
        }
        if self.bookmarkButton.point(inside: convert(point, to: bookmarkButton), with: event) {
            return self.bookmarkButton
        }
        if self.downloadButton.point(inside: convert(point, to: downloadButton), with: event) {
            return self.downloadButton
        }
        return super.hitTest(point, with: event)
    }
    
    func configure(data: HomeFeedCellProtocol) {
        cellImage.loadImage(url: data.imageName)
        photographerUsername.text = data.photographerName
    }
  
    private func setupView() {
        addSubview(photographerUsername)
        addSubview(followButton)
        addSubview(cellImage)
        addSubview(likeButton)
        addSubview(bookmarkButton)
        addSubview(downloadButton)
        NSLayoutConstraint.activate([
            photographerUsername.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            photographerUsername.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            photographerUsername.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            followButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            followButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            followButton.heightAnchor.constraint(equalToConstant: 40),
            followButton.widthAnchor.constraint(equalToConstant: 80),
            
            cellImage.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 8),
            cellImage.leftAnchor.constraint(equalTo: leftAnchor),
            cellImage.rightAnchor.constraint(equalTo: rightAnchor),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likeButton.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8),
            likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 28),

            bookmarkButton.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8),
            bookmarkButton.leftAnchor.constraint(equalTo: likeButton.leftAnchor, constant: 60),
            
            downloadButton.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8),
            downloadButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -28)
        ])
    }
}
