//
//  SavedPhotos.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 8/9/24.
//

import Foundation

struct SavedPhotos: Codable, FavoritesFeedCellProtocol {
    var imageName: String {
        photoLink ?? ""
    }
    
    var photographer: String {
        photographerName ?? ""
    }
    
    let photoID: Int?
    let photoLink: String?
    let photographerName: String?
    var documentID: String?
}
