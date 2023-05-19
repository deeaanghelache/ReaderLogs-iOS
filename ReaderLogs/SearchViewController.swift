//
//  SearchViewController.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 09.04.2023.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    let searchBarView = UISearchBar()
    let tableView = UITableView()
    let networkManager = NetworkManager()
    var searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchViewModel.delegate = self
        title = "Search"

        // MARK: Search Bar
        searchBarView.placeholder = "Search book by title..."
        searchBarView.searchBarStyle = .minimal
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.delegate = self
        view.addSubview(searchBarView)

        // MARK: Book Table
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 140.0
        tableView.register(BookCellTableView.self, forCellReuseIdentifier: BookCellTableView.bookCellTableView)
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        view.addSubview(tableView)

        let leadingConstraintTable = NSLayoutConstraint(item: tableView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 10.0)

        let trailingConstraintTable = NSLayoutConstraint(item: tableView,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: -10.0)

        let topConstraintTable = NSLayoutConstraint(item: tableView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 50.0)

        let bottomConstraintTable = NSLayoutConstraint(item: tableView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 0.0)

        NSLayoutConstraint.activate([leadingConstraintTable,
                                     trailingConstraintTable,
                                     topConstraintTable,
                                     bottomConstraintTable])

        // MARK: Constraints
        let constraints = [
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15.0),
            searchBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -620.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        searchViewModel.refreshCache()
    }
}

extension SearchViewController: SearchViewModelDelegate {

    func didChange(_ viewModel: SearchViewModel) {
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if (searchText != "") {

            tableView.isHidden = false
            searchViewModel.search(searchText)

        } else {
            tableView.isHidden = true
        }
    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.results.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: BookCellTableView.bookCellTableView,
            for: indexPath
        ) as! BookCellTableView

        let bookViewModel = searchViewModel.results[indexPath.row]
        cell.setupUI(bookViewModel)

        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let bookDetailsViewController = BookDetailsViewController()
        bookDetailsViewController.bookViewModel = searchViewModel.results[indexPath.row]

        navigationController?.pushViewController(bookDetailsViewController, animated: true)
    }
}
