//
//  VideosEndpoint.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

enum VideosEndpoint {
    case popularVideos(page: Int?, perPage: Int?)
    case searchForVideos(query: String?, page: Int?, perPage: Int?)
    
    var path: String {
        switch self {
        case .popularVideos(page: let page, perPage: let perPage):
            return "videos/popular?page=\(page ?? 1)&per_page=\(perPage ?? 2)"
        case .searchForVideos(query: let query, page: let page, perPage: let perPage):
            return "videos/search?query=\(query ?? "nature")&page=\(page ?? 1)&per_page=\(perPage ?? 1)"
        }
    }
}
