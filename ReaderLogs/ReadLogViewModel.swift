//
//  ReadLogViewModel.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 19.05.2023.
//

import FirebaseAuth
import Foundation

protocol ReadLogViewModelDelegate {
    func didChange(_ readLogViewModel: ReadLogViewModel)
}

class ReadLogViewModel {

    var delegate: ReadLogViewModelDelegate?

    private(set) var readLogs: [ReadLogModel]?
    
    private lazy var dateFormatter: DateFormatter = {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        return dateFormatter
    }()

    var today: Int {
        return aggregateLogs(1)
    }

    var lastWeek: Int {
        return aggregateLogs(7)
    }

    var lastMonth: Int {
        return aggregateLogs(30)
    }
    
    var all: Int {
        return aggregateLogs(nil)
    }

    func refreshCache() {
        
        ModelManager.shared.fetchReadLog(by: Auth.auth().currentUser!.email!) { readLogs in

            self.readLogs = readLogs
            self.delegate?.didChange(self)
        }
    }

    private func aggregateLogs(_ dayCount: Int?) -> Int {

        var days = [String]()
        for i in 0..<(dayCount ?? 0) {

            let day = Calendar.current.date(byAdding: .day, value: -i, to: Date())!
            days.append(dateFormatter.string(from: day))
        }

        return readLogs?
            .filter({ readLogModel in
                return dayCount != nil ? days.contains(readLogModel.date) : true
            })
            .reduce(0, { partialResult, readLogModel in
                return partialResult + readLogModel.pages
            }) ?? 0
    }
}
