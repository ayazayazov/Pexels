//
//  HomeVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

class HomeVM {
    var items = [PhotoData]()
    
    let dataForTab1 = ["Item 1", "Item 2", "Item 3"]
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    var photoData: Photo?
    let photosManager = PhotosManager()
    
    func getPhotos() {
        photosManager.getCuratedPhotos(page: 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photoData = data
                self.items.append(contentsOf: data.photos ?? [])
                self.success?()
            }
        }
    }
}
