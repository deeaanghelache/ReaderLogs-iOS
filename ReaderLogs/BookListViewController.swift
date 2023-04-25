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

    override func viewDidLoad() {
        super.viewDidLoad()

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

}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
//        return userBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookCellTableView.bookCellTableView,
                                                            for: indexPath) as? BookCellTableView {
            
//                    cell.layer.masksToBounds = true
//                    cell.layer.cornerRadius = 10
//                    cell.layer.borderWidth = 1.0
//                    cell.layer.shadowOffset = CGSize(width: -1, height: 1)
//                    cell.layer.borderColor = UIColor.lightGray.cgColor

                    return cell
                } else {
                    return UITableViewCell()
                }
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // aici cod pt details
    }
}
