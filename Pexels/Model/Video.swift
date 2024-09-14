//
//  Video.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    let page, perPage: Int?
    let videos: [VideoElement]?
    let totalResults: Int?
    let nextPage, url: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case videos
        case totalResults = "total_results"
        case nextPage = "next_page"
        case url
    }
}

// MARK: - VideoElement
struct VideoElement: Codable, HomeFeedCellProtocol {
    var imageName: String {
        image ?? ""
    }
    
    var photographerName: String {
        user?.name ?? ""
    }
    
    let id, width, height, duration: Int
    let url: String?
    let image: String?
    let user: User?
    let videoFiles: [VideoFile]?
    let videoPictures: [VideoPicture]?

    enum CodingKeys: String, CodingKey {
        case id, width, height, duration
        case url, image
        case user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let url: String?
}

// MARK: - VideoFile
struct VideoFile: Codable {
    let id: Int?
    let quality: Quality?
    let fileType: FileType?
    let width, height: Int?
    let fps: Double?
    let link: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case id, quality
        case fileType = "file_type"
        case width, height, fps, link, size
    }
}

enum FileType: String, Codable {
    case videoMp4 = "video/mp4"
}

enum Quality: String, Codable {
    case hd = "hd"
    case sd = "sd"
    case uhd = "uhd"
}

// MARK: - VideoPicture
struct VideoPicture: Codable {
    let id, nr: Int?
    let picture: String?
}
