//
//  ModelManager.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 15.05.2023.
//

import FirebaseDatabase
import Foundation

class ModelManager {

    static let shared = ModelManager()

    private var ref: DatabaseReference!
    private var observers = [DatabaseHandle]()

    private init() {
        ref = Database.database(url: "https://readerlogs-ios-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    }

    deinit {
        observers.forEach { observer in
            ref.removeObserver(withHandle: observer)
        }
    }
    
    private func safeKey(_ key: String) -> String {
        return key.components(separatedBy: CharacterSet(charactersIn: ".#$[]")).joined(separator: "-")
    }

    func fetchBookById(_ email: String, _ bookId: String, _ cb: @escaping (FirebaseBookModel?) -> Void) {

        let bookRef = self.ref.child(safeKey("\(email)/books/\(bookId)"))
        let observer = bookRef.observe(.value) { snapshot in

            // if value for the given path doesn't exist yet, we must inform the caller
            guard snapshot.exists() else {

                cb(nil)
                return
            }

            // if value for the given path is invalid, we must log the error and early return
            guard let model = FirebaseBookModel(snapshot) else {

                NSLog(
                    "Could not create Firebase Book Model for user with email %@ and bookId %@ due to invalid snapshot data",
                    email,
                    bookId
                )
                return
            }

            // if all good, we must inform the caller
            cb(model)
        }

        // keep reference to all observers in order to not leak them at cleanup
        observers.append(observer)
    }
    
    func storeBook(_ email: String, _ book: FirebaseBookModel) {

        let bookRef = self.ref.child(safeKey("\(email)/books/\(book.id)"))
        bookRef.setValue(book.toDict())
    }
}
