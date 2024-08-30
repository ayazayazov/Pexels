//
//  HomeFeedHeader.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 29/8/24.
//

import UIKit

class HomeFeedHeader: UICollectionReusableView, UISearchBarDelegate {
    static let identifier = "HomeFeedHeader"
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.backgroundImage = UIImage()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private let segment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Photos", "Videos"])
        sc.selectedSegmentIndex = 0
        //        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    public func configure() {
        searchBarSetup()
        segmentSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func searchBarSetup() {
        searchBar.delegate = self
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func segmentSetup() {
        addSubview(segment)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            segment.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            segment.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            segment.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // Handle search action here
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Handle text changes here
    }
    
}
