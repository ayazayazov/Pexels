//
//  CollectionMedia.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 5/9/24.
//

import Foundation

// MARK: - CollectionMedia
struct CollectionMedia: Codable {
    let page, perPage: Int?
    let media: [Media]?
    let totalResults: Int?
    let nextPage, prevPage: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case media
        case totalResults = "total_results"
        case nextPage = "next_page"
        case prevPage = "prev_page"
        case id
    }
}

// MARK: - Media
struct Media: Codable, CollectionDetailCellProtocol {
    var photoImageName: String {
        src?.large2X ?? ""
    }
    
    var videoImageName: String {
        image ?? ""
    }

    var photographerName: String {
        photographer ?? ""
    }
    
    var videographerName: String {
        user?.name ?? ""
    }
    
    let type: String?
    let id, width, height: Int
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let src: MediaSrc?
    let liked: Bool?
    let alt: String?
    let duration: Int?
//    let fullRes: JSONNull?
//    let tags: [JSONAny]?
    let image: String?
    let user: Username?
    let videoFiles: [VideoFileCollection]?
    let videoPictures: [VideoPictureCollection]?

    enum CodingKeys: String, CodingKey {
        case type, id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt, duration
//        case fullRes = "full_res"
//        case tags
        case image, user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

// MARK: - Src
struct MediaSrc: Codable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}

//enum TypeEnum: String, Codable {
//    case photo = "Photo"
//    case video = "Video"
//}

// MARK: - User
struct Username: Codable {
    let id: Int?
    let name: String?
    let url: String?
}

// MARK: - VideoFile
struct VideoFileCollection: Codable {
    let id: Int?
    let quality: QualityCollection?
    let fileType: FileTypeCollection?
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

enum FileTypeCollection: String, Codable {
    case videoMp4 = "video/mp4"
}

enum QualityCollection: String, Codable {
    case hd = "hd"
    case sd = "sd"
    case uhd = "uhd"
}

// MARK: - VideoPicture
struct VideoPictureCollection: Codable {
    let id, nr: Int?
    let picture: String?
}
