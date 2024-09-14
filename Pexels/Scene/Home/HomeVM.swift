//
//  HomeVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation
import FirebaseFirestoreInternal

class HomeVM {
    // MARK: - PHOTO
    
    var items = [PhotoData]()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    var photoData: Photo?
    let photosManager = PhotosManager()
    
    func getCuratedPhotos() {
        photosManager.getCuratedPhotos(page: (photoData?.page ?? 0) + 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photoData = data
                self.items.append(contentsOf: data.photos ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int) {
        let currentPage = photoData?.page ?? 1
        let totalPages = (photoData?.totalResults ?? 0) / (photoData?.perPage ?? 0)
        if index == items.count-2 && currentPage <= totalPages {
            getCuratedPhotos()
        }
    }
    
    func reset() {
        photoData = nil
        items.removeAll()
        getCuratedPhotos()
    }
    
    // MARK: - VIDEO
    
    var videoItems = [VideoElement]()
    
    var successVIDEO: (() -> Void)?
    var errorVIDEO: ((String) -> Void)?
    
    var videoData: Video?
    let videosManager = VideosManager()
    
    func getPopularVideos() {
        videosManager.getPopularVideos(page: (videoData?.page ?? 0) + 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.errorVIDEO?(errorMessage)
            } else if let data {
                self.videoData = data
                self.videoItems.append(contentsOf: data.videos ?? [])
                self.successVIDEO?()
            }
        }
    }
    
    func videoPagination(index: Int) {
        let currentPage = videoData?.page ?? 1
        let totalPages = (videoData?.totalResults ?? 0) / (videoData?.perPage ?? 0)
        if index == videoItems.count-2 && currentPage <= totalPages {
            getPopularVideos()
        }
    }
    
    func videoReset() {
        videoData = nil
        videoItems.removeAll()
        getPopularVideos()
    }
    

    
    // MARK: - Saved Photos
    
    var savedPhotosItems = [SavedPhotos]()
    
    var successSavedPhotos: (() -> Void)?
    var errorSavedPhotos: ((String) -> Void)?
    
    let db = Firestore.firestore()
//    var videoData: Video?
//    let videosManager = VideosManager()
    
    func getSavedPhotos() {
        savedPhotosItems.removeAll()
        db.collection("users/ayazayazov00@gmail.com/savedPhotos").getDocuments { snapshot, error in
            if let error {
                self.errorSavedPhotos?(error.localizedDescription)
            } else if let snapshot {
                for document in snapshot.documents {
                    print("document ->", document.documentID)
                    let dict = document.data()
                    if let jsonData = try? JSONSerialization.data(withJSONObject: dict) {
                        do {
                            var item = try JSONDecoder().decode(SavedPhotos.self, from: jsonData)
                            item.documentID = document.documentID
                            self.savedPhotosItems.append(item)
                            self.successSavedPhotos?()
                        } catch {
                            self.errorSavedPhotos?(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}
