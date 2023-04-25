//
//  Book.swift
//  ReaderLogs
//
//  Created by Maria Duțu on 03.04.2023.
//

import Foundation

struct BookResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let categories: [String]?
    let pageCount: Int?
    let imageLinks: ImageLinks
    let publishedDate: String?
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.volumeInfo = try container.decode(VolumeInfo.self, forKey: .volumeInfo)
    }
    
}
