//
//  SearchResultsVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 14/9/24.
//

import Foundation

class SearchResultsVM {
    // MARK: - Search For Photos
    
    var searchedPhotosItems = [PhotoData]()
    
    var successSearchedPhotos: (() -> Void)?
    var errorSearchedPhotos: ((String) -> Void)?
    
    var searchedPhotoData: Photo?
    let searchedPhotosManager = PhotosManager()
    
    func getSearchForPhotos(query: String?) {
        searchedPhotosManager.getSearchForPhotos(query: query, page: (searchedPhotoData?.page ?? 0) + 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.errorSearchedPhotos?(errorMessage)
            } else if let data {
                self.searchedPhotoData = data
                self.searchedPhotosItems.append(contentsOf: data.photos ?? [])
                self.successSearchedPhotos?()
            }
            
        }
    }
    
    func searchedPhotosPagination(index: Int, query: String) {
        let currentPage = searchedPhotoData?.page ?? 1
        let totalPages = (searchedPhotoData?.totalResults ?? 0) / (searchedPhotoData?.perPage ?? 0)
        if index == searchedPhotosItems.count-2 && currentPage <= totalPages {
            getSearchForPhotos(query: query)
        }
    }
    
    func searchedPhotosReset(query: String) {
        searchedPhotoData = nil
        searchedPhotosItems.removeAll()
        getSearchForPhotos(query: query)
    }
    
    // MARK: - Search For Videos
    
    var searchedVideosItems = [VideoElement]()
    
    var successSearchedVideos: (() -> Void)?
    var errorSearchedVideos: ((String) -> Void)?
    
    var searchedVideosData: Video?
    let searchedVideosManager = VideosManager()
    
    func getsearchForVideos(query: String?) {
        searchedVideosManager.getsearchForVideos(query: query, page: (searchedVideosData?.page ?? 0) + 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.errorSearchedVideos?(errorMessage)
            } else if let data {
                self.searchedVideosData = data
                self.searchedVideosItems.append(contentsOf: data.videos ?? [])
                self.successSearchedVideos?()
            }
            
        }
    }
    
    func searchedVideosPagination(index: Int, query: String) {
        let currentPage = searchedVideosData?.page ?? 1
        let totalPages = (searchedVideosData?.totalResults ?? 0) / (searchedVideosData?.perPage ?? 0)
        if index == searchedVideosItems.count-2 && currentPage <= totalPages {
            getsearchForVideos(query: query)
        }
    }
    
    func searchedVideosReset(query: String) {
        searchedVideosData = nil
        searchedVideosItems.removeAll()
        getsearchForVideos(query: query)
    }
}
