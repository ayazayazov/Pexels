//
//  CollectionsEndpoint.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 4/9/24.
//

import Foundation

enum CollectionsEndpoint {
    case featuredCollections(page: Int?, perPage: Int?)
    case collectionMedia(page: Int?, perPage: Int?, collectionID: String)
    
    var path: String {
        switch self {
        case .featuredCollections(let page, let perPage):
            return "v1/collections/featured?page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        case .collectionMedia(let page, let perPage, let collectionID):
            return "v1/collections/\(collectionID)?page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        }
    }
}
