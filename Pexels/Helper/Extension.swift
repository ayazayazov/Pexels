//
//  Extension.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 27/8/24.
//

import UIKit
import Foundation
import Kingfisher

extension UIImageView {
    func loadImage(url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}

extension UIViewController {
    func showAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
