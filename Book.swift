//
//  Book.swift
//  ReaderLogs
//
//  Created by Maria Duțu on 03.04.2023.
//

import Foundation

struct BookResponse: Decodable {
    let books: [Book]
}


struct Book: Decodable {
    let id: String
    let title: String
    let authors: [String]
    let category: [String]
    let nrOfPages: Int
    let description: String
    let cover: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case authors = "authors"
        case category = "categories"
        case nrOfPages = "pageCount"
        case description = "description"
        case cover = "image"
    }
    
}
