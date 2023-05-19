//
//  ReadLogModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 19.05.2023.
//

import FirebaseDatabase
import Foundation

class ReadLogModel {
    
    private(set) var date: String
    private(set) var pages: Int
    
    init(_ snapshot: DataSnapshot) {

        self.date = String(snapshot.key.split(separator: "/").last!)
        self.pages = snapshot.value as! Int
    }
}
