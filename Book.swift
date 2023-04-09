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
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct Book: Codable {
    let id: String
    let categories: [String]?
    let pageCount: Int?
    let volumeInfo: VolumeInfo
}
