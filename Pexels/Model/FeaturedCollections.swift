//
//  FeaturedCollections.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 4/9/24.
//

import Foundation

// MARK: - FeaturedCollections
struct FeaturedCollections: Codable {
    let page, perPage: Int?
    let collections: [Collection]?
    let totalResults: Int?
    let nextPage: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case collections
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
}

// MARK: - Collection
struct Collection: Codable, SearchFeedCellProtocol {
    var collectionTitle: String {
        title ?? ""
    }
    var mediaLabel: Int {
        mediaCount ?? 0
    }
    
    let id, title, description: String?
    let collectionPrivate: Bool?
    let mediaCount, photosCount, videosCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case collectionPrivate = "private"
        case mediaCount = "media_count"
        case photosCount = "photos_count"
        case videosCount = "videos_count"
    }
}
