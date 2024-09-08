//
//  FavoritesFeedCell.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 7/9/24.
//

import UIKit

protocol FavoritesFeedCellProtocol{
    var imageName: String { get }
    var photographer: String { get }
}

class FavoritesFeedCell: UICollectionViewCell {
    
    private let photographerUsername: UILabel = {
        let il = UILabel()
        il.numberOfLines = 0
        il.font = .systemFont(ofSize: 14, weight: .regular)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    private let cellImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let deleteButton: UIButton = {
        let ub = UIButton()
        ub.setImage(UIImage(named: "bookmark-slash"), for: .normal)
        ub.tintColor = .black
        ub.backgroundColor = .clear
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
        if self.deleteButton.point(inside: convert(point, to: deleteButton), with: event) {
            return self.deleteButton
        }
        return super.hitTest(point, with: event)
    }
    
    func configure(data: FavoritesFeedCellProtocol) {
        cellImage.loadImage(url: data.imageName)
        photographerUsername.text = data.photographer
    }
  
    private func setupView() {
        addSubview(photographerUsername)
        addSubview(cellImage)
        addSubview(deleteButton)
        NSLayoutConstraint.activate([
            photographerUsername.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            photographerUsername.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            deleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            
            cellImage.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 8),
            cellImage.leftAnchor.constraint(equalTo: leftAnchor),
            cellImage.rightAnchor.constraint(equalTo: rightAnchor),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
