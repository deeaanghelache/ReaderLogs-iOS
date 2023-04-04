//
//  BookListViewController.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 02.04.2023.
//

import UIKit

class BookListViewController: UIViewController {
    
    let tableView = UITableView()
//    let searchBarView = UISearchBar()
//    let searchBar = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Books"
        
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
        
        
//        searchBar.text = "Search Bar"
//        // left
//        let leadingConstraintSearch = NSLayoutConstraint(item: tableView,
//                                                   attribute: .leading,
//                                                   relatedBy: .equal,
//                                                   toItem: view,
//                                                   attribute: .leading,
//                                                   multiplier: 1.0,
//                                                   constant: 10.0)
//        // right
//        let trailingConstraintSearch = NSLayoutConstraint(item: tableView,
//                                                    attribute: .trailing,
//                                                    relatedBy: .equal,
//                                                    toItem: view,
//                                                    attribute: .trailing,
//                                                    multiplier: 1.0,
//                                                    constant: 10.0)
//        let topConstraintSearch = NSLayoutConstraint(item: tableView,
//                                               attribute: .top,
//                                               relatedBy: .equal,
//                                               toItem: view.safeAreaLayoutGuide,
//                                               attribute: .top,
//                                               multiplier: 1.0,
//                                               constant: 0.0)
//        let bottomConstraintSearch = NSLayoutConstraint(item: tableView,
//                                                  attribute: .bottom,
//                                                  relatedBy: .equal,
//                                                  toItem: view.safeAreaLayoutGuide,
//                                                  attribute: .bottom,
//                                                  multiplier: 1.0,
//                                                  constant: -450.0)
//        NSLayoutConstraint.activate([leadingConstraintSearch,
//                                     trailingConstraintSearch,
//                                     topConstraintSearch,
//                                     bottomConstraintSearch])
//
//
//        view.addSubview(searchBar)
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
