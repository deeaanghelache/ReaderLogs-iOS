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
    //        let rating // daca e finished -> afiseaza
    // percentage daca e done
    var progressView = UIProgressView(progressViewStyle: .bar)

    // MARK: Init function
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        BookCellTableView.bookCellTableViewCount += 1

        // Cover
        cellBookCoverView.translatesAutoresizingMaskIntoConstraints = false
        cellBookCoverView.backgroundColor = .purple
        cellBookCoverView.layer.cornerRadius = 10.0
        cellBookCoverView.clipsToBounds = true
        cellBookCoverView.frame.size.height = 80.0
        contentView.addSubview(cellBookCoverView)

        // Title
        cellBookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellBookTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        cellBookTitleLabel.text = "Book Title"
        contentView.addSubview(cellBookTitleLabel)

        // Author
        cellBookAuthor.translatesAutoresizingMaskIntoConstraints = false
        cellBookAuthor.font = UIFont.systemFont(ofSize: 14.0)
        cellBookAuthor.text = "by Book Author"
        contentView.addSubview(cellBookAuthor)

        // Label -> done, currently reading
        cellStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        cellStatusLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        cellStatusLabel.text = "  Reading now "
        cellStatusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        cellStatusLabel.textColor = .white
//        cellStatusLabel.numberOfLines = 2
        cellStatusLabel.layer.borderColor = UIColor.tintColor.cgColor
        cellStatusLabel.layer.borderWidth = 1.0
        cellStatusLabel.backgroundColor = .tintColor
        cellStatusLabel.layer.cornerRadius = 12.0
        cellStatusLabel.clipsToBounds = true
        contentView.addSubview(cellStatusLabel)
        
        // Progress
        var progressValue = 0.7
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(Float(progressValue), animated: false)
        progressView.layer.cornerRadius = 5.0
        progressView.clipsToBounds = true
        progressView.backgroundColor = .lightGray
        contentView.addSubview(progressView)
        

        let constraints = [
            cellBookCoverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            cellBookCoverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellBookCoverView.widthAnchor.constraint(equalToConstant: 80.0),
            cellBookCoverView.heightAnchor.constraint(equalToConstant: 100.0),

            cellBookTitleLabel.leadingAnchor.constraint(equalTo: cellBookCoverView.trailingAnchor, constant: 10.0),
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
            progressView.heightAnchor.constraint(equalToConstant: 5.0)
//            progressView.widthAnchor.constraint(equalToConstant: 230.0)
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
