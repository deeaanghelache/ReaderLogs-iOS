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
    
    private var viewModel: ReadLogViewModel = ReadLogViewModel()

    private var todayProgress: SummaryProgressView = SummaryProgressView()
    private var thisWeekProgress: SummaryProgressView = SummaryProgressView()
    private var thisMonthProgress: SummaryProgressView = SummaryProgressView()
    private var recordProgress: SummaryProgressView = SummaryProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        title = "Reading Progress"

        viewModel.delegate = self

        todayProgress.title = "Today"
        todayProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayProgress)

        thisWeekProgress.title = "Last 7 days"
        thisWeekProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thisWeekProgress)

        thisMonthProgress.title = "Last 30 days"
        thisMonthProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thisMonthProgress)

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshCache()
    }

    func setupUI(with viewModel: ReadLogViewModel) {
        
        todayProgress.pages = viewModel.today
        thisWeekProgress.pages = viewModel.lastWeek
        thisMonthProgress.pages = viewModel.lastMonth
        recordProgress.pages = viewModel.all
    }
}

extension HomeViewController: ReadLogViewModelDelegate {

    func didChange(_ viewModel: ReadLogViewModel) {
        setupUI(with: viewModel)
    }
}
