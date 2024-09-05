//
//  Photo.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let page, perPage: Int?
    let photos: [PhotoData]?
    let totalResults: Int?
    let nextPage: String?

    enum CodingKeys: String, CodingKey {
        case page, photos
        case perPage = "per_page"
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
}

// MARK: - PhotoElement
struct PhotoData: Codable, HomeFeedCellProtocol {
    var imageName: String {
        src?.large2X ?? ""
    }
    var photographerName: String {
        photographer ?? ""
    }
    
    let id, width, height: Int
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let src: Src?
    let liked: Bool?
    let alt: String?

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
    }
}

// MARK: - Src
struct Src: Codable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}
