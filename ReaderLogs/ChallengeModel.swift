//
//  ChallengeModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 19.05.2023.
//

import FirebaseDatabase
import Foundation

class ChallengeModel {

    private(set) var booksTotal: Int
    
    init(_ booksTotal: Int) {
        self.booksTotal = booksTotal
    }

    init?(_ snapshot: DataSnapshot) {

        guard let dict = snapshot.value as! [String : Any]? else {
            return nil
        }

        self.booksTotal = dict["booksTotal"] as! Int
    }
    
    func toDict() -> [String : Any] {
        
        return [
            "booksTotal": self.booksTotal,
        ]
    }
}
