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
    
    func configure(data: HomeFeedCellProtocol) {
        cellImage.loadImage(url: data.imageName)
        photographerUsername.text = data.photographerName
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
        photographerUsername.setContentHuggingPriority(.required, for: .vertical)
        photographerUsername.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
