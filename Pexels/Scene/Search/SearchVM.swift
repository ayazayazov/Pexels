//
//  SearchVM.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 4/9/24.
//

import Foundation

class SearchVM {
    var items = [Collection]()

    var success: (() -> Void)?
    var error: ((String) -> Void)?

    var collectionData: FeaturedCollections?
    let collectionsManager = CollectionsManager()

    func getFeaturedCollections() {
        collectionsManager.getFeaturedCollections(page: (collectionData?.page ?? 0) + 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                print(errorMessage)
            } else if let data {
                self.collectionData = data
                self.items.append(contentsOf: data.collections ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int) {
        let currentPage = collectionData?.page ?? 1
        let totalPages = (collectionData?.totalResults ?? 0) / (collectionData?.perPage ?? 0)
        if index == items.count-2 && currentPage <= totalPages {
            getFeaturedCollections()
        }
    }
    
    func reset() {
        collectionData = nil
        items.removeAll()
        getFeaturedCollections()
    }
}

