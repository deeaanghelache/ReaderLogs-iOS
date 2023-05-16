//
//  BookViewModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 14.05.2023.
//

import Foundation
import UIKit

struct ModelSource: OptionSet {

    let rawValue: Int

    static let none: ModelSource = []
    static let googleBooks = ModelSource(rawValue: 1 << 0)
    static let firebaseDB = ModelSource(rawValue: 1 << 1)
    static let all: ModelSource = [.googleBooks, .firebaseDB]
}

class BookViewModel: NSObject, FirebaseBookModelDelegate {

    private(set) var googleBook: GoogleBookModel?
    private(set) var firebaseBook: FirebaseBookModel?

    private(set) var source: ModelSource = .none
    private(set) var cover: String?
    private(set) var title: String
    private(set) var author: String
    private(set) var status: BookStatus
    private(set) var rating: Int?
    private(set) var startDate: String?
    private(set) var endDate: String?
    private(set) var pagesRead: Int?
    private(set) var pagesTotal: Int?

    private(set) var details: String?
    private(set) var bookDescription: String?

    private lazy var dateFormatter: DateFormatter = {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter
    }()

    init(_ googleBook: GoogleBookModel) {

        source.update(with: .googleBooks)
        self.googleBook = googleBook

        cover = googleBook.volumeInfo.imageLinks.thumbnail
        title = googleBook.volumeInfo.title
        author = googleBook.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author"
        status = .none

        var pageCount = "-"
        if let count = googleBook.volumeInfo.pageCount {
            pageCount = "\(count)"
        }

        details = """
Categories: \(googleBook.volumeInfo.categories?.joined(separator: ", ") ?? "-")
Published date: \(googleBook.volumeInfo.publishedDate ?? "-")
Page count: \(pageCount)
"""

        if let description = googleBook.volumeInfo.description {
            bookDescription = "\t\(description)"
        } else {
            bookDescription = "-"
        }

        super.init()
    }

    init(_ firebaseBook: FirebaseBookModel) {

        source.update(with: .firebaseDB)
        self.firebaseBook = firebaseBook

        cover = firebaseBook.cover
        title = firebaseBook.title
        author = firebaseBook.author
        status = firebaseBook.status
        rating = firebaseBook.rating
        startDate = firebaseBook.startDate
        endDate = firebaseBook.endDate
        pagesRead = firebaseBook.pagesRead
        pagesTotal = firebaseBook.pagesTotal
        
        super.init()
        
        firebaseBook.delegate = self
    }

    convenience init (_ googleBook: GoogleBookModel, _ firebaseBook: FirebaseBookModel) {

        self.init(googleBook)
        self.setup(with: firebaseBook)
    }

    private func setup(with firebaseBook: FirebaseBookModel) {
        
        source.update(with: .firebaseDB)
        self.firebaseBook = firebaseBook

        cover = firebaseBook.cover
        title = firebaseBook.title
        author = firebaseBook.author
        status = firebaseBook.status
        rating = firebaseBook.rating
        startDate = firebaseBook.startDate
        endDate = firebaseBook.endDate
        pagesRead = firebaseBook.pagesRead
        pagesTotal = firebaseBook.pagesTotal
        
        firebaseBook.delegate = self
    }

    func updateStatus(_ status: BookStatus) {

        if source.contains(.firebaseDB),
           let firebaseBook = self.firebaseBook {

            // If the View Model is already backed by a Firebase Model -> make use of it & update DB

            firebaseBook.updateStatus(status)
            

        } else if status != .none,
                  let googleBook = self.googleBook,
                  let firebaseBook = FirebaseBookModel(googleBook) {
            
            // Otherwise -> create the Firebase Model, make use of it & update DB

            setup(with: firebaseBook)
            firebaseBook.updateStatus(status)
        }
    }

    func updateRating(_ rating: Int) {
        
        guard
            source.contains(.firebaseDB),
            let firebaseBook = self.firebaseBook
        else {
            return
        }
        firebaseBook.updateRating(rating)
    }

    func incrementPagesRead(_ pages: Int) {

        guard
            source.contains(.firebaseDB),
            let firebaseBook = self.firebaseBook
        else {
            return
        }
        firebaseBook.incrementPagesRead(pages)
    }
    
    // MARK: FirebaseBookModelDelegate

    func didChangeStatus(_ status: BookStatus) {
        self.status = status
    }
    
    func didChangeRating(_ rating: Int) {
        self.rating = rating
    }
    
    func didChangePagesRead(_ pagesRead: Int) {
        self.pagesRead = pagesRead
    }
}
