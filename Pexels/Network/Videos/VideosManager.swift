//
//  VideosManager.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

protocol VideosManagerUseCase {
    func getPopularVideos(page: Int?, perPage: Int?, completion: @escaping((Video?, String?) -> Void))
}

class VideosManager: VideosManagerUseCase {
    func getPopularVideos(page: Int?, perPage: Int?, completion: @escaping ((Video?, String?) -> Void)) {
        let endpoint = VideosEndpoint.popularVideos(page: page, perPage: perPage)
        NetworkManager.request(model: Video.self, endpoint: endpoint.path, completion: completion)
    }
   
}
