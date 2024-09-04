//
//  CollectionsManager.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 4/9/24.
//

import Foundation

protocol CollectionsManagerUseCase {
    func getFeaturedCollections(page: Int?, perPage: Int?, completion: @escaping((FeaturedCollections?, String?) -> Void))
}

class CollectionsManager: CollectionsManagerUseCase {
    func getFeaturedCollections(page: Int?, perPage: Int?, completion: @escaping ((FeaturedCollections?, String?) -> Void)) {
        let endpoint = CollectionsEndpoint.featuredCollections(page: page, perPage: perPage)
        NetworkManager.request(model: FeaturedCollections.self, endpoint: endpoint.path, completion: completion)
    }
    
   
}
