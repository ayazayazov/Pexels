//
//  VideosManager.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

protocol VideosManagerUseCase {
    func getPopularVideos(page: Int?, perPage: Int?, completion: @escaping((Video?, String?) -> Void))
    func getsearchForVideos(query: String?, page: Int?, perPage: Int?, completion: @escaping((Video?, String?) -> Void))
}

class VideosManager: VideosManagerUseCase {
    func getsearchForVideos(query: String?, page: Int?, perPage: Int?, completion: @escaping ((Video?, String?) -> Void)) {
        let endpoint = VideosEndpoint.searchForVideos(query: query, page: page, perPage: perPage)
        NetworkManager.request(model: Video.self, endpoint: endpoint.path, completion: completion)
    }
    
    func getPopularVideos(page: Int?, perPage: Int?, completion: @escaping ((Video?, String?) -> Void)) {
        let endpoint = VideosEndpoint.popularVideos(page: page, perPage: perPage)
        NetworkManager.request(model: Video.self, endpoint: endpoint.path, completion: completion)
    }
   
}
