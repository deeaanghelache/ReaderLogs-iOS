//
//  SearchViewModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 17.05.2023.
//

import FirebaseAuth
import Foundation

protocol SearchViewModelDelegate {
    func didChange(_ viewModel: SearchViewModel)
}

class SearchViewModel {

    var delegate: SearchViewModelDelegate?
    private(set) var results: [BookViewModel] = []

    private let networkManager = NetworkManager()
    private var firebaseBookRegistry: [String : FirebaseBookModel] = [:]
    private var timer: Timer?
    private var searchText: String?

    func refreshCache() {
        
        ModelManager.shared.fetchBooks(by: Auth.auth().currentUser!.email!) { firebaseBooks in

            guard let books = firebaseBooks else {
                return
            }

            for book in books {
                self.firebaseBookRegistry[book.id] = book
            }

            var results: [BookViewModel] = []
            for bookViewModel in self.results {

                if let firebaseBook = self.firebaseBookRegistry[bookViewModel.googleBook!.id] {
                    results.append(BookViewModel(bookViewModel.googleBook!, firebaseBook))
                } else {
                    results.append(BookViewModel(bookViewModel.googleBook!))
                }
            }
            self.results = results
            self.delegate?.didChange(self)
        }
    }

    func search(_ text: String) {

        self.searchText = text

        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 0.3,
            target: self,
            selector: #selector(performSearch),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func performSearch() {

        networkManager.fetchBooks(searchText ?? "") { books in

            var results: [BookViewModel] = []
            for googleBook in books {

                if let firebaseBook = self.firebaseBookRegistry[googleBook.id] {
                    results.append(BookViewModel(googleBook, firebaseBook))
                } else {
                    results.append(BookViewModel(googleBook))
                }
            }
            self.results = results
            self.delegate?.didChange(self)
        }
    }
}
