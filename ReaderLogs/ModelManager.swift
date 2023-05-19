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
    
    func fetchBooks(by email: String, _ cb: @escaping ([FirebaseBookModel]?) -> Void) {
        
        let booksRef = self.ref.child(safeKey("\(email)/books"))
        booksRef.getData(completion: { error, snapshot in

            // if value for the given path doesn't exist yet, we must inform the caller
            guard let snapshot = snapshot, snapshot.exists() else {

                cb(nil)
                return
            }

            var models: [FirebaseBookModel] = []
            for childAny in snapshot.children {

                let child = childAny as! DataSnapshot

                // if value for the given path is invalid, we must log the error and early return
                guard let model = FirebaseBookModel(child) else {

                    NSLog(
                        "Could not create Firebase Book Model for user with email %@ and bookId %@ due to invalid snapshot data",
                        email,
                        child.key
                    )
                    cb(nil)
                    return
                }
                models.append(model)
            }

            // if all good, we must inform the caller
            cb(models)
        })
    }
    
    func fetchReadLog(by email: String, _ cb: @escaping ([ReadLogModel]?) -> Void) {

        let readLogRef = self.ref.child(safeKey("\(email)/readLog"))
        readLogRef.getData(completion: { error, snapshot in

            // if value for the given path doesn't exist yet, we must inform the caller
            guard let snapshot = snapshot, snapshot.exists() else {

                cb(nil)
                return
            }

            let models: [ReadLogModel] = snapshot.children.map { childAny in
                let child = childAny as! DataSnapshot
                return ReadLogModel(child)
            }

            // if all good, we must inform the caller
            cb(models)
        })
    }
    
    func fetchReadLog(by email: String, _ day: String, _ cb: @escaping (Int?) -> Void) {

        let readLogRef = self.ref.child(safeKey("\(email)/readLog/\(day)"))
        readLogRef.getData(completion: { error, snapshot in

            // if value for the given path doesn't exist yet, we must inform the caller
            guard let snapshot = snapshot, snapshot.exists() else {

                cb(nil)
                return
            }

            // if all good, we must inform the caller
            cb(snapshot.value as? Int)
        })
    }
    
    func updateReadLog(by email: String, _ day: String, _ count: Int) {

        let readLogRef = self.ref.child(safeKey("\(email)/readLog/\(day)"))
        readLogRef.setValue(count)
    }

    func storeBook(_ email: String, _ book: FirebaseBookModel) {

        let bookRef = self.ref.child(safeKey("\(email)/books/\(book.id)"))
        bookRef.setValue(book.toDict())
    }
}
