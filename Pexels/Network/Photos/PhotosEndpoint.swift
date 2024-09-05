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
            return "v1/curated?page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        case .photoID(let id):
            return "v1/photos/\(id ?? 123453)"
        }

        
    }
}
