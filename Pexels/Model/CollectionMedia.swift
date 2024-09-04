//
//  CollectionMedia.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

// MARK: - CollectionMedia
struct CollectionMedia: Codable {
    let page, perPage: Int?
    let media: [Media]?
    let totalResults: Int?
    let nextPage: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case media
        case totalResults = "total_results"
        case nextPage = "next_page"
        case id
    }
}

// MARK: - Media
struct Media: Codable {
    let type: String?
    let id, width, height: Int?
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let mediaSrc: MediaSrc?
    let liked: Bool?
    let alt: String?

    enum CodingKeys: String, CodingKey {
        case type, id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case mediaSrc, liked, alt
    }
}

// MARK: - Src
struct MediaSrc: Codable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}
