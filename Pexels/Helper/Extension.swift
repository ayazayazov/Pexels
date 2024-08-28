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
    }
}
