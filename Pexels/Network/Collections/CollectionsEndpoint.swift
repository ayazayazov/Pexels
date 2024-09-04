//
//  CollectionsEndpoint.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 4/9/24.
//

import Foundation

enum CollectionsEndpoint {
    case featuredCollections(page: Int?, perPage: Int?)
    
    var path: String {
        switch self {
        case .featuredCollections(let page, let perPage):
            return "collections/featured?page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        }
    }
}
