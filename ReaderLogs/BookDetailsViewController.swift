//
//  BookDetailsViewController.swift
//  ReaderLogs
//
//  Created by Maria Duțu on 09.04.2023.
//

import UIKit
import Kingfisher

class BookDetailsViewController: UIViewController, UIScrollViewDelegate {
    var index: Int?
    var books = [Book]()
    
    let scrollView = UIScrollView() // Replace view with scrollView
    let contentView = UIView() // Add a contentView inside scrollView to hold all subviews
    
    let bookCoverView = UIImageView()
    let bookCoverBackgroundView = UIImageView()
    let bookTitleView = UILabel()
    let bookAuthorsView = UILabel()
    let bookPageCountView = UILabel()
    let bookDescriptionTitleView = UILabel()
    let bookDescriptionView = UITextView()
    let bookDetailsTitleView = UILabel()
    let bookDetailsView = UITextView()
    let bookReadingLogView = UILabel()
    let statusButton = UIButton()
    let line1 = UILabel()
    let line2 = UILabel()
    let startedReading = UILabel()
    let finishedReading = UILabel()
    let updateProgressButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let book = books[index ?? 0]
        scrollView.backgroundColor = .white // Set background color for scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self // Set delegate to self
        view.addSubview(scrollView)
                
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView) // Add contentView inside scrollView
        
        bookCoverBackgroundView.backgroundColor = .lightGray
        bookCoverBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookCoverBackgroundView)
        
        bookCoverView.backgroundColor = .black
        bookCoverView.translatesAutoresizingMaskIntoConstraints = false
        bookCoverView.layer.cornerRadius = 10
        bookCoverView.kf.cancelDownloadTask()
        bookCoverView.image = nil
        let imageUrl = URL(string: book.volumeInfo.imageLinks.thumbnail ?? "image")
        bookCoverView.kf.setImage(with: imageUrl)
        bookCoverView.clipsToBounds = true
        contentView.addSubview(bookCoverView)
        
        bookTitleView.text = book.volumeInfo.title
        bookTitleView.font = UIFont.boldSystemFont(ofSize: 18)
        bookTitleView.translatesAutoresizingMaskIntoConstraints = false
        bookTitleView.textAlignment = .center
        bookTitleView.numberOfLines = 5
        contentView.addSubview(bookTitleView)
        
        if let authors = book.volumeInfo.authors {
            bookAuthorsView.text = "by \(authors.joined(separator: ", "))"
        } else {
            bookAuthorsView.text = "unknown author"
        }
        bookAuthorsView.translatesAutoresizingMaskIntoConstraints = false
        bookAuthorsView.textAlignment = .center
        bookAuthorsView.numberOfLines = 3
        contentView.addSubview(bookAuthorsView)
        
        let menuStatusButtonClosure = { (action: UIAction) in
            self.updateStatus(value: action.title)
        }
        statusButton.menu = UIMenu(children: [
            UIAction(title: "Want to Read", state: .on, handler: menuStatusButtonClosure),
            UIAction(title: "Reading", handler: menuStatusButtonClosure),
            UIAction(title: "Finished", handler: menuStatusButtonClosure)
        ])
        statusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        let downArrowImage = UIImage(systemName: "chevron.down")
        statusButton.setImage(downArrowImage, for: .normal)
        statusButton.semanticContentAttribute = .forceRightToLeft
        statusButton.tintColor = .white
        statusButton.backgroundColor = .systemGreen
        statusButton.layer.cornerRadius = 5
        statusButton.showsMenuAsPrimaryAction = true
        statusButton.changesSelectionAsPrimaryAction = true
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statusButton)
        
//        ReadingLog
        line1.text = ""
        line1.layer.borderColor = UIColor.gray.cgColor
        line1.layer.borderWidth = 1.5
        line1.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        line1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(line1)
        
//        TODO: IF-URI
//        reading
        startedReading.text = "→ You started reading this book on 1 Apr 2023"
        startedReading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(startedReading)
//        finished
        finishedReading.text = "→ You finished this book on 13 Apr 2023"
        finishedReading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(finishedReading)
        
//        Reading:
//        Text
//        Buton Update progress
        
        updateProgressButton.setTitle("Update progress", for: .normal)
//        updateProgressButton.backgroundColor = .white
//        updateProgressButton.layer.borderColor = UIColor.gray.cgColor
        updateProgressButton.layer.cornerRadius = 5
        updateProgressButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(updateProgressButton)
        
//        Progress bar + procent
        
//        Finished:
//        Text
//        Rating
        
        line2.text = ""
        line2.layer.borderColor = UIColor.gray.cgColor
        line2.layer.borderWidth = 1.5
        line2.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        line2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(line2)
        
        bookDetailsTitleView.text = "Details"
        bookDetailsTitleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookDetailsTitleView)
        
        let emptyText = "-"
        if let categories = book.volumeInfo.categories {
            bookDetailsView.text = "Categories: \(categories.joined(separator: ", "))\n"
        } else {
            bookDetailsView.text = "Categories: \(emptyText)\n"
        }
        
        if let nrOfPages = book.volumeInfo.pageCount {
            bookDetailsView.text += "Page count: \(nrOfPages)"
        } else {
            bookDetailsView.text += "Page count: \(emptyText)"
        }
        bookDetailsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookDetailsView)
        
        bookDescriptionTitleView.text = "Description"
        bookDescriptionTitleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookDescriptionTitleView)

        if let description = book.volumeInfo.description {
            bookDescriptionView.text = "\t\(description)"
            bookDescriptionView.textAlignment = .justified
            bookDescriptionView.isScrollEnabled = false
        } else {
            bookDescriptionView.text = emptyText
        }
        bookDescriptionView.isEditable = false
        bookDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookDescriptionView)
        
        // MARK: Constraints
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // Pin scrollView to view edges
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                       
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor), // Pin contentView to scrollView edges
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Set contentView width equal to scrollView width
            
            bookCoverBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            bookCoverBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            bookCoverBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            bookCoverBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -425.0),
            
            bookCoverView.leadingAnchor.constraint(equalTo: bookCoverBackgroundView.leadingAnchor, constant: 100.0),
            bookCoverView.trailingAnchor.constraint(equalTo: bookCoverBackgroundView.trailingAnchor, constant: -100.0),
            bookCoverView.topAnchor.constraint(equalTo: bookCoverBackgroundView.topAnchor, constant: 10.0),
            bookCoverView.bottomAnchor.constraint(equalTo: bookCoverBackgroundView.bottomAnchor, constant: -15.0),
            bookCoverView.heightAnchor.constraint(equalToConstant: 250),
            
            bookTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.0),
            bookTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.0),
            bookTitleView.topAnchor.constraint(equalTo: bookCoverBackgroundView.bottomAnchor, constant: 5.0),
            bookTitleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -375.0),
            
            bookAuthorsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.0),
            bookAuthorsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.0),
            bookAuthorsView.topAnchor.constraint(equalTo: bookTitleView.bottomAnchor, constant: 5.0),
            bookAuthorsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -350.0),
            
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100.0),
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100.0),
            statusButton.topAnchor.constraint(equalTo: bookAuthorsView.bottomAnchor, constant: 5.0),
            statusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -300.0),
            
            statusButton.imageView!.leadingAnchor.constraint(equalTo: statusButton.leadingAnchor, constant: 10.0),
            statusButton.imageView!.topAnchor.constraint(equalTo: statusButton.topAnchor, constant: 10.0),
            statusButton.imageView!.bottomAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: -10.0),
            
            line1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            line1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            line1.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 15.0),
            
            startedReading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            startedReading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            startedReading.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 10.0),
            startedReading.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -250.0),
            
            finishedReading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            finishedReading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            finishedReading.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 10.0),
            finishedReading.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -250.0),
            
            updateProgressButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            updateProgressButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            updateProgressButton.topAnchor.constraint(equalTo: startedReading.bottomAnchor, constant: 10.0),
            updateProgressButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -190.0),
            
            
//            line2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
//            line2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
//            line2.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 15.0),
            
            
//            bookDetailsTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
//            bookDetailsTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
//            bookDetailsTitleView.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 0.0),
//            bookDetailsTitleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -250.0),
//
//            bookDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
//            bookDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
//            bookDetailsView.topAnchor.constraint(equalTo: bookDetailsTitleView.bottomAnchor, constant: 5.0),
//            bookDetailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -170.0),
//
//            bookDescriptionTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
//            bookDescriptionTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
//            bookDescriptionTitleView.topAnchor.constraint(equalTo: bookDetailsView.bottomAnchor, constant: 5.0),
//            bookDescriptionTitleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150.0),
//
//            bookDescriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
//            bookDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
//            bookDescriptionView.topAnchor.constraint(equalTo: bookDescriptionTitleView.bottomAnchor, constant: 5.0),
//            bookDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateStatus(value:String) {
        switch value {
        case "Want to Read":
            statusButton.backgroundColor = .systemGreen
        case "Reading":
            statusButton.backgroundColor = .systemYellow
        case "Finished":
            statusButton.backgroundColor = .systemBlue
        default:
            statusButton.backgroundColor = .systemGreen
        }
    }

}
