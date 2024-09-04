//
//  PhotoDetailVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 2/9/24.
//

import Foundation

class PhotoDetailVM {
    var photoDetails = [PhotoData]()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    var photoData: PhotoData?
    let photosManager = PhotosManager()
    
    func getPhotosID(id: Int?) {
        photosManager.getPhotoID(id: id) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                print(errorMessage)
            } else if let data {
                self.photoData = data
//                self.photoDetails.append(contentsOf: data ?? [])
//                print(self.photoDetails)
                self.success?()
            }
        }
    }
}
