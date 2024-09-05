//
//  VideosManager.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

//protocol VideosManagerUseCase {
//    func getPopularVideos(page: Int?, perPage: Int?, completion: @escaping((FeaturedCollections?, String?) -> Void))
//}
//
//class VideosManager: VideosManagerUseCase {
//    func getCollectionMedia(page: Int?, perPage: Int?, collectionID: String, completion: @escaping ((CollectionMedia?, String?) -> Void)) {
//        let endpoint = CollectionsEndpoint.collectionMedia(page: page, perPage: perPage, collectionID: collectionID)
//        NetworkManager.request(model: CollectionMedia.self, endpoint: endpoint.path, completion: completion)
//    }
//    
//    func getFeaturedCollections(page: Int?, perPage: Int?, completion: @escaping ((FeaturedCollections?, String?) -> Void)) {
//        let endpoint = CollectionsEndpoint.featuredCollections(page: page, perPage: perPage)
//        NetworkManager.request(model: FeaturedCollections.self, endpoint: endpoint.path, completion: completion)
//    }
//    
//   
//}
