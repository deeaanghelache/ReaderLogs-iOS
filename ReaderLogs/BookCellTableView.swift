//
//  BookCellTableView.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 03.04.2023.
//

import UIKit

class BookCellTableView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Static variables
    static let bookCellTableView = "bookCellTableView"
    static var bookCellTableViewCount = 0

    // MARK: UI Variables
    let cellBookCoverView = UIImageView()
    let cellBookTitleLabel = UILabel()
    let cellBookAuthor = UILabel()
    let cellStatusLabel = UILabel()  // doar daca e in progress sau finished
    var rating = 4 // daca e finished -> afiseaza
    var ratingView = UILabel()
    let progressView = UIProgressView(progressViewStyle: .bar)
    var progressValue = 0.7
    var finished = false

    // MARK: Init function
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        BookCellTableView.bookCellTableViewCount += 1

        // Cover
        cellBookCoverView.translatesAutoresizingMaskIntoConstraints = false
        cellBookCoverView.backgroundColor = .lightGray
        cellBookCoverView.layer.cornerRadius = 10.0
        cellBookCoverView.clipsToBounds = true
        cellBookCoverView.frame.size.height = 80.0
        contentView.addSubview(cellBookCoverView)

        // Title
        cellBookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellBookTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        cellBookTitleLabel.text = "Book Title"
        cellBookTitleLabel.numberOfLines = 2
        contentView.addSubview(cellBookTitleLabel)

        // Author
        cellBookAuthor.translatesAutoresizingMaskIntoConstraints = false
        cellBookAuthor.font = UIFont.systemFont(ofSize: 14.0)
        cellBookAuthor.text = "by Book Author"
        contentView.addSubview(cellBookAuthor)

        // Label -> done, currently reading
        cellStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        cellStatusLabel.font = UIFont.systemFont(ofSize: 14.0)
        cellStatusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        cellStatusLabel.textColor = .white
        cellStatusLabel.layer.borderWidth = 1.0
        cellStatusLabel.layer.cornerRadius = 12.0
        cellStatusLabel.clipsToBounds = true
        cellStatusLabel.textAlignment = .center
        
        if (finished) {
            cellStatusLabel.layer.borderColor = UIColor.systemGreen.cgColor
            cellStatusLabel.backgroundColor = .systemGreen
            cellStatusLabel.text = "Done"
        } else {
            cellStatusLabel.layer.borderColor = UIColor.lightGray.cgColor
            cellStatusLabel.backgroundColor = .lightGray
            cellStatusLabel.text = "Reading Now"
        }
        contentView.addSubview(cellStatusLabel)
        
        // Progress
        if (!finished) {
            progressView.setProgress(Float(progressValue), animated: false)
            progressView.layer.cornerRadius = 5.0
            progressView.clipsToBounds = true
            progressView.backgroundColor = .lightGray
        }
        progressView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(progressView)
        
        // Rating
        if (finished) {
            var fullStars = ""
            var emptyStars = ""
            var remainingStars = 5 - rating
            
            for _ in 1...rating {
                fullStars += "★"
            }
            
            for _ in 0...remainingStars {
                emptyStars += "☆"
            }
            
            var allStars = "\(fullStars)\(emptyStars)"

            ratingView.text = String(allStars.dropLast())
            ratingView.font = UIFont.boldSystemFont(ofSize: 20)
            ratingView.textColor = UIColor.systemYellow
        }
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingView)
        
        let constraints = [
            cellBookCoverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            cellBookCoverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellBookCoverView.widthAnchor.constraint(equalToConstant: 80.0),
            cellBookCoverView.heightAnchor.constraint(equalToConstant: 100.0),

            cellBookTitleLabel.leadingAnchor.constraint(equalTo: cellBookCoverView.trailingAnchor, constant: 10.0),
            cellBookTitleLabel.trailingAnchor.constraint(equalTo: cellStatusLabel.leadingAnchor, constant: -10.0),
            cellBookTitleLabel.topAnchor.constraint(equalTo: cellBookCoverView.topAnchor),

            cellBookAuthor.leadingAnchor.constraint(equalTo: cellBookTitleLabel.leadingAnchor),
            cellBookAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70.0),
            cellBookAuthor.topAnchor.constraint(equalTo: cellBookTitleLabel.bottomAnchor, constant: 5.0),

            cellStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            cellStatusLabel.widthAnchor.constraint(equalToConstant: 100.0),
            cellStatusLabel.heightAnchor.constraint(equalToConstant: 25.0),
            cellStatusLabel.topAnchor.constraint(equalTo: cellBookCoverView.topAnchor),
            
            progressView.bottomAnchor.constraint(equalTo: cellBookCoverView.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: cellBookCoverView.trailingAnchor, constant: 10.0),
            progressView.trailingAnchor.constraint(equalTo: cellStatusLabel.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 5.0),
            
            ratingView.topAnchor.constraint(equalTo: cellStatusLabel.bottomAnchor, constant: 10.0),
            ratingView.trailingAnchor.constraint(equalTo: cellStatusLabel.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        BookCellTableView.bookCellTableViewCount -= 1
    }
}
