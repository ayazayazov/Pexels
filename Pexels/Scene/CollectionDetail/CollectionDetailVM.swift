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
    
    func getCollectionMedia(page: Int?, perPage: Int?, collectionID: String) {
        collectionsManager.getCollectionMedia(page: page, perPage: perPage, collectionID: collectionID) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                print(errorMessage)
            } else if let data {
                self.collectionData = data
                print(data)
                self.items.append(contentsOf: data.media ?? [])
                self.success?()
            }
        }
    }
}
