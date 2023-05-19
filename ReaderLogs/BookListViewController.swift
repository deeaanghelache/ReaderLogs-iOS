//
//  BookListViewController.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 02.04.2023.
//

import UIKit

class BookListViewController: UIViewController {
    
    let tableView = UITableView()
    let allButton = UIButton()
    let currentlyReadingButton = UIButton()
    let finishedButton = UIButton()
    let toReadButton = UIButton()
    let searchBarView = UISearchBar()
    let networkManager = NetworkManager()
    var bookListViewModel = BookListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookListViewModel.delegate = self
        
        // MARK: Title
        title = "My Books"
        
        // MARK: Book Table
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 140.0
        tableView.register(BookCellTableView.self, forCellReuseIdentifier: BookCellTableView.bookCellTableView)
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // left
        let leadingConstraintTable = NSLayoutConstraint(item: tableView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 10.0)
        // right
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
                                               constant: 100.0)
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
        
        // MARK: Search Bar
        searchBarView.placeholder = "Search book by title..."
        searchBarView.searchBarStyle = .minimal
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.delegate = self
        view.addSubview(searchBarView)
        
        // left
        let leadingConstraintSearch = NSLayoutConstraint(item: searchBarView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 10.0)
        // right
        let trailingConstraintSearch = NSLayoutConstraint(item: searchBarView,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: -10.0)
        let topConstraintSearch = NSLayoutConstraint(item: searchBarView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 15.0)
        let bottomConstraintSearch = NSLayoutConstraint(item: searchBarView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -620.0)
        NSLayoutConstraint.activate([leadingConstraintSearch,
                                     trailingConstraintSearch,
                                     topConstraintSearch,
                                     bottomConstraintSearch])
        
        // MARK: All button
        allButton.setTitle("All", for: .normal)
        allButton.backgroundColor = .tintColor
        allButton.layer.cornerRadius = 10.0
        allButton.clipsToBounds = true
        allButton.translatesAutoresizingMaskIntoConstraints = false
        allButton.addTarget(self, action: #selector(didTapAllButton), for: .touchUpInside)
        view.addSubview(allButton)
        
        // left
        let leadingConstraintAllButton = NSLayoutConstraint(item: allButton,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 20.0)
        // right
        let trailingConstraintAllButton = NSLayoutConstraint(item: allButton,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: -330.0)
        let topConstraintAllButton = NSLayoutConstraint(item: allButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 60.0)
        let bottomConstraintAllButton = NSLayoutConstraint(item: allButton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -580.0)
        NSLayoutConstraint.activate([leadingConstraintAllButton,
                                     trailingConstraintAllButton,
                                     topConstraintAllButton,
                                     bottomConstraintAllButton])
        
        // MARK: Currently Reading Button
        currentlyReadingButton.setTitle("Reading Now", for: .normal)
        currentlyReadingButton.backgroundColor = .tintColor
        currentlyReadingButton.layer.cornerRadius = 10.0
        currentlyReadingButton.clipsToBounds = true
        currentlyReadingButton.translatesAutoresizingMaskIntoConstraints = false
        currentlyReadingButton.addTarget(self, action: #selector(didTapReadingButton), for: .touchUpInside)
        view.addSubview(currentlyReadingButton)
        
        // left
        let leadingConstraintCurrentlyReadingButton = NSLayoutConstraint(item: currentlyReadingButton,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 70.0)
        // right
        let trailingConstraintCurrentlyReadingButton = NSLayoutConstraint(item: currentlyReadingButton,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: -200.0)
        let topConstraintCurrentlyReadingButton = NSLayoutConstraint(item: currentlyReadingButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 60.0)
        let bottomConstraintCurrentlyReadingButton = NSLayoutConstraint(item: currentlyReadingButton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -580.0)
        NSLayoutConstraint.activate([leadingConstraintCurrentlyReadingButton,
                                     trailingConstraintCurrentlyReadingButton,
                                     topConstraintCurrentlyReadingButton,
                                     bottomConstraintCurrentlyReadingButton])
        
        // MARK: Finished Button
        finishedButton.setTitle("Finished", for: .normal)
        finishedButton.backgroundColor = .tintColor
        finishedButton.layer.cornerRadius = 10.0
        finishedButton.clipsToBounds = true
        finishedButton.translatesAutoresizingMaskIntoConstraints = false
        finishedButton.addTarget(self, action: #selector(didTapFinishedButton), for: .touchUpInside)
        view.addSubview(finishedButton)
        
        // left
        let leadingConstraintFinishedButton = NSLayoutConstraint(item: finishedButton,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 200.0)
        // right
        let trailingConstraintFinishedButton = NSLayoutConstraint(item: finishedButton,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: -110.0)
        let topConstraintFinishedButton = NSLayoutConstraint(item: finishedButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 60.0)
        let bottomConstraintFinishedButton = NSLayoutConstraint(item: finishedButton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -580.0)
        NSLayoutConstraint.activate([leadingConstraintFinishedButton,
                                     trailingConstraintFinishedButton,
                                     topConstraintFinishedButton,
                                     bottomConstraintFinishedButton])
        
        // MARK: Want To Read Button
        toReadButton.setTitle("To Read", for: .normal)
        toReadButton.backgroundColor = .tintColor
        toReadButton.layer.cornerRadius = 10.0
        toReadButton.clipsToBounds = true
        toReadButton.translatesAutoresizingMaskIntoConstraints = false
        toReadButton.addTarget(self, action: #selector(didTapWantToReadButton), for: .touchUpInside)
        view.addSubview(toReadButton)
        
        // left
        let leadingConstraintToReadButton = NSLayoutConstraint(item: toReadButton,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 290.0)
        // right
        let trailingConstraintToReadButton = NSLayoutConstraint(item: toReadButton,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: -20.0)
        let topConstraintToReadButton = NSLayoutConstraint(item: toReadButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 60.0)
        let bottomConstraintToReadButton = NSLayoutConstraint(item: toReadButton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -580.0)
        NSLayoutConstraint.activate([leadingConstraintToReadButton,
                                     trailingConstraintToReadButton,
                                     topConstraintToReadButton,
                                     bottomConstraintToReadButton])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        bookListViewModel.refreshCache()
    }

    @objc func didTapAllButton(sender: UIButton!) {
        bookListViewModel.filter(by: nil)
    }

    @objc func didTapReadingButton(sender: UIButton!) {
        bookListViewModel.filter(by: .reading)
    }

    @objc func didTapFinishedButton(sender: UIButton!) {
        bookListViewModel.filter(by: .finished)
    }

    @objc func didTapWantToReadButton(sender: UIButton!) {
        bookListViewModel.filter(by: .wantToRead)
    }
}

extension BookListViewController: BookListViewModelDelegate {

    func didChange(_ viewModel: BookListViewModel) {
        tableView.reloadData()
    }
}

extension BookListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        bookListViewModel.filter(by: searchText)
    }
}

extension BookListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookListViewModel.results.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: BookCellTableView.bookCellTableView,
            for: indexPath)
        as! BookCellTableView
        
        let bookViewModel = bookListViewModel.results[indexPath.row]
        cell.setupUI(bookViewModel)
        
        return cell
    }
}

extension BookListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let bookDetailsViewController = BookDetailsViewController()
        bookDetailsViewController.bookViewModel = bookListViewModel.results[indexPath.row]

        navigationController?.pushViewController(bookDetailsViewController, animated: true)
    }
}
