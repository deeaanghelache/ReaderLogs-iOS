//
//  HomeViewController.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 02.04.2023.
//

import UIKit
import FirebaseAuthUI

//TODO: make it responsive for smaller screens (maybe use UITableView)

class HomeViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        title = "Reading Progress"
        
        let todayProgress = SummaryProgressView()
        todayProgress.title = "Today"
        todayProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayProgress)
        
        let thisWeekProgress = SummaryProgressView()
        thisWeekProgress.title = "This week"
        thisWeekProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thisWeekProgress)
        
        let thisMonthProgress = SummaryProgressView()
        thisMonthProgress.title = "This month"
        thisMonthProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thisMonthProgress)
        
        let recordProgress = SummaryProgressView()
        recordProgress.title = "Record"
        recordProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordProgress)
        
        let constaints = [
            todayProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            todayProgress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            todayProgress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            thisWeekProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            thisWeekProgress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            thisWeekProgress.topAnchor.constraint(equalTo: todayProgress.bottomAnchor, constant: 15.0),
            thisMonthProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            thisMonthProgress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            thisMonthProgress.topAnchor.constraint(equalTo: thisWeekProgress.bottomAnchor, constant: 15.0),
            recordProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            recordProgress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            recordProgress.topAnchor.constraint(equalTo: thisMonthProgress.bottomAnchor, constant: 15.0)
        ]
        
        NSLayoutConstraint.activate(constaints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
