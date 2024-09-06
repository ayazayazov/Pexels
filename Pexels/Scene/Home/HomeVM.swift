//
//  HomeVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation

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
}
