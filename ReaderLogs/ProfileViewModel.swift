//
//  ProfileViewModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 19.05.2023.
//

import FirebaseAuth
import Foundation

protocol ProfileViewModelDelegate {
    func didChange(_ profileViewModel: ProfileViewModel)
}

class ProfileViewModel {
    
    var delegate: ProfileViewModelDelegate?
    
    var challenge: ChallengeModel?
    var allBooks: [FirebaseBookModel]?
    
    var booksRead: Int {
        
        let finishedBooks = allBooks?.filter({ book in
            return book.status == .finished
        })
        return finishedBooks?.count ?? 0
    }

    var booksTotal: Int {
        return challenge?.booksTotal ?? 0
    }

    func refreshCache() {

        var pendingRequests = 2
        ModelManager.shared.fetchChallenge(by: Auth.auth().currentUser!.email!) { challenge in

            self.challenge = challenge
            pendingRequests -= 1
            if pendingRequests == 0 {
                self.delegate?.didChange(self)
            }
        }
        
        ModelManager.shared.fetchBooks(by: Auth.auth().currentUser!.email!) { books in

            self.allBooks = books
            pendingRequests -= 1
            if pendingRequests == 0 {
                self.delegate?.didChange(self)
            }
        }
    }

    func setupChallenge(_ books: Int) {

        let challenge = ChallengeModel(books)
        ModelManager.shared.storeChallenge(Auth.auth().currentUser!.email!, challenge)

        self.refreshCache()
    }
}
