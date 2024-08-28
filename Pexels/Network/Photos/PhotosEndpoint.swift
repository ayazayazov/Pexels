//
//  PhtosoHelper.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

enum PhotosEndpoint {
    case curatedPhotos(page: Int?, perPage: Int?)
    
    var path: String {
        switch self {
        case .curatedPhotos(let page, let perPage):
            return "curated?page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        }
        
    }
}
