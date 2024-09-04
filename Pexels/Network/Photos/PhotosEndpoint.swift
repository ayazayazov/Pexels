//
//  PhtosoHelper.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

enum PhotosEndpoint {
    case curatedPhotos(page: Int?, perPage: Int?)
    case photoID(id: Int?)
    
    var path: String {
        switch self {
        case .curatedPhotos(let page, let perPage):
            return "curated?page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        case .photoID(let id):
            return "photos/\(id ?? 123453)"
        }

        
    }
}
