//
//  ImageRationCalc.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

class ImageRationCalc {
    func calc(width: Int, height: Int) -> CGFloat {
        let ration = CGFloat(height) / CGFloat(width)
        return ration
    }
}
