//
//  BookDetailsViewController.swift
//  ReaderLogs
//
//  Created by Maria Duțu on 09.04.2023.
//

import UIKit
import Kingfisher

class BookDetailsViewController: UIViewController, UIScrollViewDelegate {

    var bookViewModel: BookViewModel?

    let scrollView = UIScrollView() // Replace view with scrollView
    let bookCoverView = UIImageView()
    let bookTitleView = UILabel()
    let bookAuthorsView = UILabel()
    let bookPageCountView = UILabel()
    let bookDescriptionTitleView = UILabel()
    let bookDescriptionView = UITextView()
    let bookDetailsTitleView = UILabel()
    let bookDetailsView = UILabel()
    let bookReadingLogView = UILabel()
    let statusButton = UIButton()
    let line1 = UILabel()
    let line2 = UILabel()
    let line3 = UILabel()
    let startedReading = UILabel()
    let finishedReading = UILabel()
    let updateProgressButton = UIButton()
    let stackView = UIStackView()
    var currentPageNumber = 0
    var currentStatus = BookStatus.wantToRead
    let progressView = UIProgressView(progressViewStyle: .bar)
    let progressStack = UIStackView()
    let progressPercentageView = UILabel()
    var progressPercentage = 0.0
    let starStackView = UIStackView()
    var rating = 0
    var starImageViews: [UIImageView] = []
    let starFillImage = UIImage(systemName: "star.fill")
    let starEmptyImage = UIImage(systemName: "star")
    var currentPageCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentPageCount = bookViewModel!.pagesTotal ?? 0

        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        // Create a stack view
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // Add stack view to the scroll view
        scrollView.addSubview(stackView)
        
        bookCoverView.backgroundColor = .white
        bookCoverView.translatesAutoresizingMaskIntoConstraints = false
        bookCoverView.kf.cancelDownloadTask()
        bookCoverView.image = nil
        
        if let cover = bookViewModel!.cover {
            bookCoverView.kf.setImage(with: URL(string: cover))
        } else {
            bookCoverView.image = UIImage(named: "placeholderImage")
        }

        bookCoverView.contentMode = .center
//        bookCoverView.layer.cornerRadius = 10
//        bookCoverView.clipsToBounds = true
        stackView.addArrangedSubview(bookCoverView)
        
        bookTitleView.text = bookViewModel!.title
        bookTitleView.font = UIFont.boldSystemFont(ofSize: 18)
        bookTitleView.translatesAutoresizingMaskIntoConstraints = false
        bookTitleView.textAlignment = .center
        bookTitleView.numberOfLines = 5
        stackView.addArrangedSubview(bookTitleView)

        bookAuthorsView.text = "by \(bookViewModel!.author)"
        bookAuthorsView.translatesAutoresizingMaskIntoConstraints = false
        bookAuthorsView.textAlignment = .center
        bookAuthorsView.numberOfLines = 3
        stackView.addArrangedSubview(bookAuthorsView)
        
        let menuStatusButtonClosure = { (action: UIAction) in
            self.bookViewModel?.updateStatus(BookStatus(rawValue: action.title)!)
            self.updateStatus(value: action.title)
        }
        statusButton.menu = UIMenu(children: [
            UIAction(title: BookStatus.none.rawValue, state: .on, handler: menuStatusButtonClosure),
            UIAction(title: BookStatus.wantToRead.rawValue, handler: menuStatusButtonClosure),
            UIAction(title: BookStatus.reading.rawValue, handler: menuStatusButtonClosure),
            UIAction(title: BookStatus.finished.rawValue, handler: menuStatusButtonClosure)
        ])
        statusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        let downArrowImage = UIImage(systemName: "chevron.down")
        statusButton.setImage(downArrowImage, for: .normal)
        statusButton.semanticContentAttribute = .forceRightToLeft
        statusButton.tintColor = .white
        statusButton.backgroundColor = .systemGray
        statusButton.layer.cornerRadius = 5
        statusButton.showsMenuAsPrimaryAction = true
        statusButton.changesSelectionAsPrimaryAction = true
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        statusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        stackView.addArrangedSubview(statusButton)

        self.updateStatus(value: BookStatus.none.rawValue)

        // TODO: rating just when status = .finished
        
//        RATING
        starStackView.axis = .horizontal
        starStackView.distribution = .fillProportionally
        starStackView.translatesAutoresizingMaskIntoConstraints = false

        for index in 0...4 {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = starEmptyImage
            starStackView.addArrangedSubview(starImageView)
            starImageViews.append(starImageView)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
            starImageViews[index].addGestureRecognizer(tapGesture)
            starImageViews[index].isUserInteractionEnabled = true
            starStackView.addArrangedSubview(starImageView)
        }
        stackView.addArrangedSubview(starStackView)
        
//        READING LOG
        line1.text = ""
        line1.layer.borderColor = UIColor.gray.cgColor
        line1.layer.borderWidth = 1.5
        line1.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        line1.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(line1)
        
//        TODO: IF-URI
//        reading
        startedReading.text = "→ You started this book on 1 Apr 2023"
        startedReading.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(startedReading)
//        finished
        finishedReading.text = "→ You finished this book on 13 Apr 2023"
        finishedReading.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(finishedReading)
        
        // PROGRESS BAR + PERCENTAGE
        progressStack.axis = .horizontal
        progressStack.translatesAutoresizingMaskIntoConstraints = false
        progressStack.heightAnchor.constraint(equalToConstant: 20).isActive = true
        progressStack.spacing = 10
        stackView.addArrangedSubview(progressStack)
        
        if let pagesTotal = bookViewModel!.pagesTotal {
            progressPercentage = Double(bookViewModel!.pagesRead ?? 0) / Double(pagesTotal)
        } else {
            progressPercentage = 0.0
        }

        progressView.setProgress(Float (progressPercentage), animated: false)
        progressView.accessibilityIdentifier = "progressView"
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.backgroundColor = .lightGray
        progressView.tintColor = .systemYellow
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressStack.addArrangedSubview(progressView)
        
        let percentageInt = Int(progressPercentage * 100)
        progressPercentageView.text = "\(percentageInt)%"
        progressPercentageView.textColor = .black
        progressStack.addArrangedSubview(progressPercentageView)
        
//        UPDATE PROGRESS BUTTON
        updateProgressButton.setTitle("Update progress", for: .normal)
        updateProgressButton.backgroundColor = .white
        updateProgressButton.setTitleColor(.darkGray, for: .normal)
        updateProgressButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        updateProgressButton.layer.borderColor = UIColor.darkGray.cgColor
        updateProgressButton.layer.borderWidth = 1
        updateProgressButton.layer.cornerRadius = 5
        updateProgressButton.translatesAutoresizingMaskIntoConstraints = false
        updateProgressButton.addTarget(self, action: #selector(updateProgress), for: .touchUpInside)
        stackView.addArrangedSubview(updateProgressButton)

        if bookViewModel!.source == .googleBooks {

            line2.text = ""
            line2.layer.borderColor = UIColor.gray.cgColor
            line2.layer.borderWidth = 1.5
            line2.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            line2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(line2)

            bookDetailsTitleView.text = "ℹ️ Details"
            bookDetailsTitleView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(bookDetailsTitleView)

            bookDetailsView.text = bookViewModel!.details
            bookDetailsView.numberOfLines = 3
            bookDetailsView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(bookDetailsView)

            line3.text = ""
            line3.layer.borderColor = UIColor.gray.cgColor
            line3.layer.borderWidth = 1.5
            line3.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            line3.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(line3)

            bookDescriptionTitleView.text = "Description"
            bookDescriptionTitleView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(bookDescriptionTitleView)
            
            bookDescriptionView.text = bookViewModel!.bookDescription
            bookDescriptionView.textAlignment = .justified
            bookDescriptionView.isScrollEnabled = false
            bookDescriptionView.isEditable = false
            bookDescriptionView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(bookDescriptionView)
        }
        
        // MARK: Constraints
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), // Pin scrollView to view edges
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
//            BOOK STATUS BUTTON
            stackView.arrangedSubviews[3].leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 90.0),
            stackView.arrangedSubviews[3].trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -90.0),

            statusButton.imageView!.leadingAnchor.constraint(equalTo: statusButton.leadingAnchor, constant: 10.0),
            statusButton.imageView!.topAnchor.constraint(equalTo: statusButton.topAnchor, constant: 5.0),
            statusButton.imageView!.bottomAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: -5.0),
            
            starStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 120.0),
            starStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -120.0),
            
            progressStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10.0),
            progressStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10.0),
            
            updateProgressButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 70.0),
            updateProgressButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -70.0),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    func updateStatus(value: String) {

        switch value {
        case BookStatus.none.rawValue:
            currentStatus = BookStatus.none
            statusButton.backgroundColor = .systemGray
            startedReading.isHidden = true
            finishedReading.isHidden = true
            progressStack.isHidden = true
            updateProgressButton.isHidden = true
            line2.isHidden = true

        case BookStatus.wantToRead.rawValue:
            currentStatus = BookStatus.wantToRead
            statusButton.backgroundColor = .systemGreen
            startedReading.isHidden = true
            finishedReading.isHidden = true
            progressStack.isHidden = true
            updateProgressButton.isHidden = true
            line2.isHidden = true

        case BookStatus.reading.rawValue:
            currentStatus = BookStatus.reading
            statusButton.backgroundColor = .systemYellow
            startedReading.isHidden = false
            finishedReading.isHidden = true
            progressStack.isHidden = false
            updateProgressButton.isHidden = false
            line2.isHidden = false

        case BookStatus.finished.rawValue:
            currentStatus = BookStatus.finished
            statusButton.backgroundColor = .systemBlue
            startedReading.isHidden = false
            finishedReading.isHidden = false
            progressStack.isHidden = false
            updateProgressButton.isHidden = true
            line2.isHidden = false

        default:
            currentStatus = BookStatus.none
            statusButton.backgroundColor = .none
            startedReading.isHidden = true
            finishedReading.isHidden = true
            progressStack.isHidden = true
            updateProgressButton.isHidden = true
            line2.isHidden = true
        }
    }

    @objc
    func updateProgress(sender: UIButton!) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Update your progress", message: "What's your current page number?", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Page number"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button
            if let inputNumber = alertController.textFields![0].text {
                if let number = Int(inputNumber) {
                    if number > 0 {
                        self.currentPageNumber = number
                        self.progressPercentage = Double(self.currentPageNumber) / Double(self.currentPageCount)
                        self.progressView.setProgress(Float(self.progressPercentage), animated: true)
                        self.progressPercentageView.text = "\(Int(self.progressPercentage * 100))%"
//                        let progress = self.progressStack.viewWithTag("progressView".hash).setProgress(currentPageNumber, animated: false)
//                        self.viewDidLoad()
                        
                    }
                } else {
                    self.currentPageNumber = 0
                }
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc func starTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedStar = gesture.view as? UIImageView else { return }

        // Get the index of the tapped star
        if let tappedIndex = starImageViews.firstIndex(of: tappedStar) {
            // Update the star images based on tapped star index
            for index in 0..<starImageViews.count {
                if index <= tappedIndex {
                    // Fill the stars up to the tapped star
                    starImageViews[index].image = starFillImage
                } else {
                    // Empty the stars after the tapped star
                    starImageViews[index].image = starEmptyImage
                }
            }
        }
    }
}
