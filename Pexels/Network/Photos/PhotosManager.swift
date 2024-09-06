//
//  PhotosManager.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

protocol PhotosManagerUseCase {
    func getCuratedPhotos(page: Int?, perPage: Int?, completion: @escaping((Photo?, String?) -> Void))
    func getPhotoID(id: Int?, completion: @escaping((PhotoData?, String?) -> Void))
}

class PhotosManager: PhotosManagerUseCase {
    func getPhotoID(id: Int?, completion: @escaping ((PhotoData?, String?) -> Void)) {
        let endpoint = PhotosEndpoint.photoID(id: id)
        NetworkManager.request(model: PhotoData.self, endpoint: endpoint.path, completion: completion)
    }
    
    func getCuratedPhotos(page: Int?, perPage: Int?, completion: @escaping ((Photo?, String?) -> Void)) {
        let endpoint = PhotosEndpoint.curatedPhotos(page: page, perPage: perPage)
        NetworkManager.request(model: Photo.self, endpoint: endpoint.path, completion: completion)
    }
}
