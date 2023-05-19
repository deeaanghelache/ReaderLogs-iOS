//
//  BookListViewModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 18.05.2023.
//

import FirebaseAuth
import Foundation

protocol BookListViewModelDelegate {
    func didChange(_ viewModel: BookListViewModel)
}

class BookListViewModel {

    var delegate: BookListViewModelDelegate?

    private(set) var results: [BookViewModel] = []
    private var allBooks: [BookViewModel] = []

    private let networkManager = NetworkManager()
    private var timer: Timer?
    private var filterText: String?
    private var filterStatus: BookStatus?

    func refreshCache() {

        ModelManager.shared.fetchBooks(by: Auth.auth().currentUser!.email!) { firebaseBooks in

            guard let books = firebaseBooks else {
                return
            }

            var results: [BookViewModel] = []
            for book in books {
                results.append(BookViewModel(book))
            }

            self.allBooks = results
            self.performFilter()
        }
    }

    func filter(by text: String) {

        self.filterText = text

        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 0.3,
            target: self,
            selector: #selector(performFilter),
            userInfo: nil,
            repeats: false
        )
    }
    
    func filter(by status: BookStatus?) {

        self.filterStatus = status
        self.performFilter()
    }

    @objc func performFilter() {

        results = allBooks.filter { bookViewModel in

            guard
                let filterText = self.filterText,
                filterText.lengthOfBytes(using: .utf8) > 0
            else {
                return self.filterStatus != nil ? bookViewModel.status == self.filterStatus : true
            }

            return bookViewModel.title.contains(filterText) && (
                self.filterStatus != nil ? bookViewModel.status == self.filterStatus : true
            )
        }
        delegate?.didChange(self)
    }
}
