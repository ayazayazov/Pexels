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
        collectionsManager.getFeaturedCollections(page: 1, perPage: 10) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                print(errorMessage)
            } else if let data {
                self.collectionData = data
                print(data)
                self.items.append(contentsOf: data.collections ?? [])
                self.success?()
            }
        }
    }
}

