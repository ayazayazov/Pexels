//
//  PhotosManager.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

protocol PhotosManagerUseCase {
    func getCuratedPhotos(page: Int?, perPage: Int?, completion: @escaping((Photo?, String?) -> Void))
}

class PhotosManager: PhotosManagerUseCase {
    func getCuratedPhotos(page: Int?, perPage: Int?, completion: @escaping ((Photo?, String?) -> Void)) {
        let endpoint = PhotosEndpoint.curatedPhotos(page: page, perPage: perPage)
        NetworkManager.request(model: Photo.self, endpoint: endpoint.path, completion: completion)
    }
   
}
