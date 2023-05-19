//
//  FirebaseBookModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 14.05.2023.
//

import FirebaseAuth
import FirebaseDatabase
import Foundation

enum BookStatus: String {
    case none = "Tap to bookmark"
    case wantToRead = "Want to read"
    case reading = "Reading"
    case finished = "Finished"
}

protocol FirebaseBookModelDelegate {
    func didChange(_ book: FirebaseBookModel)
}

class FirebaseBookModel {

    var id: String
    var cover: String?
    var title: String
    var author: String
    var status: BookStatus
    var rating: Int?
    var startDate: String?
    var endDate: String?
    var pagesRead: Int?
    var pagesTotal: Int
    
    var delegate: FirebaseBookModelDelegate?

    private lazy var dateFormatter: DateFormatter = {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter
    }()

    init?(_ snapshot: DataSnapshot) {

        guard let dict = snapshot.value as! [String : Any]? else {
            return nil
        }

        // Mandatory properties - Model is invalid without them

        guard
            let id = dict["id"] as! String?,
            let title = dict["title"] as! String?,
            let author = dict["author"] as! String?,
            let status = dict["status"] as! String?,
            let pagesTotal = dict["pagesTotal"] as! Int?
        else {
            return nil
        }

        self.id = id
        self.title = title
        self.author = author
        self.status = BookStatus(rawValue: status)!
        self.pagesTotal = pagesTotal

        // Optional properties - new Models may lack them until they are set

        self.cover = dict["cover"] as! String?
        self.rating = dict["rating"] as! Int?
        self.startDate = dict["startDate"] as! String?
        self.endDate = dict["endDate"] as! String?
        self.pagesRead = dict["pagesRead"] as! Int?
    }

    init?(_ googleBook: GoogleBookModel) {

        // Mandatory properties - Model is invalid without them

        self.id = googleBook.id
        self.title = googleBook.volumeInfo.title
        self.status = .none
        self.pagesTotal = googleBook.volumeInfo.pageCount ?? 1
        
        // Optional properties - new Models may lack them until they are set

        self.cover = googleBook.volumeInfo.imageLinks.thumbnail
        self.author = googleBook.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author"
    }

    func updateStatus(_ status: BookStatus) {

        self.status = status
        switch status {
        case .reading:
            self.startDate = self.dateFormatter.string(from: Date())

        case .finished:
            self.endDate = self.dateFormatter.string(from: Date())
            
        default:
            break
        }

        ModelManager.shared.storeBook(Auth.auth().currentUser!.email!, self)
        self.delegate?.didChange(self)
    }

    func updateRating(_ rating: Int) {
        
        guard status == .finished else {
            return
        }
        self.rating = rating

        ModelManager.shared.storeBook(Auth.auth().currentUser!.email!, self)
        self.delegate?.didChange(self)
    }

    func incrementPagesRead(_ pages: Int) {
        
        guard status == .reading else {
            return
        }

        if self.pagesRead == nil {
            self.pagesRead = 0
        }
        self.pagesRead! += pages
        self.pagesRead = min(self.pagesTotal, self.pagesRead!)

        ModelManager.shared.storeBook(Auth.auth().currentUser!.email!, self)
        self.delegate?.didChange(self)
    }

    func toDict() -> [String : Any] {

        var dict: [String : Any] = [
            "id": self.id,
            "title": self.title,
            "author": self.author,
            "status": self.status.rawValue,
            "pagesTotal": self.pagesTotal,
        ]
        
        if let cover = self.cover {
            dict["cover"] = cover
        }
        if let rating = self.rating {
            dict["rating"] = rating
        }
        if let startDate = self.startDate {
            dict["startDate"] = startDate
        }
        if let endDate = self.endDate {
            dict["endDate"] = endDate
        }
        if let pagesRead = self.pagesRead {
            dict["pagesRead"] = pagesRead
        }
        
        return dict
    }
}
