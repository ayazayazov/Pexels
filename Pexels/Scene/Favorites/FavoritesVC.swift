//
//  FavoritesVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 29/8/24.
//

import UIKit
import FirebaseFirestoreInternal
import SwiftUI

struct SavedPhotos: Codable, FavoritesFeedCellProtocol {
    var imageName: String {
        photoLink ?? ""
    }
    
    var photographer: String {
        photographerName ?? ""
    }
    
    let photoID: Int?
    let photoLink: String?
    let photographerName: String?
    let width: Int?
    let height: Int?
    var documentID: String?
}

class FavoritesVC: UIViewController {
    
    private let imageRation = ImageRationCalc()
    let db = Firestore.firestore()
    var items = [SavedPhotos]()

    private let feedLabel: UILabel = {
        let il = UILabel()
        il.text = "Saved Posts"
        il.font = .systemFont(ofSize: 30, weight: .bold)
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    private let feed: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FavoritesFeedCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        getUsers()
    }
    
    func getUsers() {
        items.removeAll()
        db.collection("users/ayazayazov00@gmail.com/savedPhotos").getDocuments { snapshot, error in
            if let error {
                print("error: \(error.localizedDescription)")
            } else if let snapshot {
                for document in snapshot.documents {
                    print("document ->", document.documentID)
                    let dict = document.data()
                    if let jsonData = try? JSONSerialization.data(withJSONObject: dict) {
                        do {
                            var item = try JSONDecoder().decode(SavedPhotos.self, from: jsonData)
                            item.documentID = document.documentID
                            self.items.append(item)
                            print(self.items)
                        } catch {
                            print("error: \(error.localizedDescription)")
                        }
                    }
                }
                self.feed.reloadData()
            }
        }
    }

    private func viewSetup() {
        view.addSubview(feedLabel)
        view.addSubview(feed)
        feed.dataSource = self
        feed.delegate = self
        NSLayoutConstraint.activate([
            feedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            feedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            feedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            feed.topAnchor.constraint(equalTo: feedLabel.bottomAnchor, constant: 20),
            feed.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            feed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    @objc func deleteAction(sender: UIButton) {
        print("Post \(sender.tag) Unsaved")
        print("Post \(sender.tag) \(items[sender.tag].documentID ?? "")")
    }
}

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: (collectionView.frame.width/2 - 10) * imageRation.calc(width: 280, height: 200) + 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoritesFeedCell
        cell.configure(data: items[indexPath.item])
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 10
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PhotoDetailVC()
        controller.photoID = items[indexPath.item].photoID
        navigationController?.show(controller, sender: nil)
    }
    
    
}
