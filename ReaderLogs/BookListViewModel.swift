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

    private let networkManager = NetworkManager()
    private var firebaseBookRegistry: [String : FirebaseBookModel] = [:]
    
    func refreshCache() {
        
        ModelManager.shared.fetchBooks(by: Auth.auth().currentUser!.email!) { firebaseBooks in

            guard let books = firebaseBooks else {
                return
            }

            var results: [BookViewModel] = []
            for book in books {
                results.append(BookViewModel(book))
            }

            self.results = results
            self.delegate?.didChange(self)
        }
    }
}
