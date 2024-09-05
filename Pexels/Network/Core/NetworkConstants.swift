//
//  NetworkConstants.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 24/8/24.
//

import Foundation
import Alamofire

class NetworkConstants {
    static let baseURL = "https://api.pexels.com/"
    static let header: HTTPHeaders = ["Authorization": "nKHdWQz4g8UR2GScONKjCFUs6QEhTnuhzx59tpzG7z0FzfOOlNLWgjFg"]
    
    static func getUrl(with endpoint: String) -> String {
        baseURL + endpoint
    }
}
