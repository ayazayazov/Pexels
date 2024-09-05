//
//  CollectionDetailVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

class CollectionDetailVM {
    var items = [Media]()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    var collectionData: CollectionMedia?
    let collectionsManager = CollectionsManager()
    
    func getCollectionMedia(collectionID: String) {
        collectionsManager.getCollectionMedia(page: (collectionData?.page ?? 0) + 1, perPage: 10, collectionID: collectionID) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                print(errorMessage)
            } else if let data {
                self.collectionData = data
                self.items.append(contentsOf: data.media ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int, collectionID: String) {
        let currentPage = collectionData?.page ?? 1
        let totalPages = (collectionData?.totalResults ?? 0) / (collectionData?.perPage ?? 0)
        if index == items.count-2 && currentPage <= totalPages {
            getCollectionMedia(collectionID: collectionID)
        }
    }
    
//    func reset(collectionID: String) {
//        collectionData = nil
//        items.removeAll()
//        getCollectionMedia(collectionID: collectionID)
//    }
}
