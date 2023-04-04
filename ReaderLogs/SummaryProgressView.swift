//
//  SummaryProgressView.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 04/04/2023.
//

import UIKit

class SummaryProgressView: UIView {
    
    var title: String {
        set {
            summaryTitle.text = newValue
        }
        get {
            return summaryTitle.text
        }
    }
    
    var pagesCount = "0 pages"
    private let summaryTitle = UITextView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        summaryTitle.translatesAutoresizingMaskIntoConstraints = false
        summaryTitle.text = ""
        summaryTitle.textColor = .black
        summaryTitle.font = UIFont.italicSystemFont(ofSize: 30.0)
        summaryTitle.isScrollEnabled = false
        self.addSubview(summaryTitle)
        
        let panelBackground = UIView()
        panelBackground.translatesAutoresizingMaskIntoConstraints = false
        panelBackground.backgroundColor = .lightGray
        panelBackground.clipsToBounds = true
        panelBackground.layer.cornerRadius = 20.0
        self.addSubview(panelBackground)
        
        let summaryLabel = UILabel()
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.text = "Read pages"
        summaryLabel.textAlignment = .left
        summaryLabel.textColor = .white
        summaryLabel.font = summaryLabel.font.withSize(20.0)
        panelBackground.addSubview(summaryLabel)
        
        let summaryPagesCount = UILabel()
        summaryPagesCount.translatesAutoresizingMaskIntoConstraints = false
        summaryPagesCount.text = pagesCount
        summaryPagesCount.textAlignment = .center
        summaryPagesCount.textColor = .white
        summaryPagesCount.font = summaryPagesCount.font.withSize(25.0)
        panelBackground.addSubview(summaryPagesCount)
        
        let constaints = [
            //Title
            summaryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            summaryTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            summaryTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            summaryTitle.heightAnchor.constraint(equalToConstant: 50.0),
            
            //Panel
            panelBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            panelBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            panelBackground.topAnchor.constraint(equalTo: summaryTitle.bottomAnchor, constant: 10.0),
            panelBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            panelBackground.heightAnchor.constraint(equalToConstant: 70.0),
            summaryLabel.leadingAnchor.constraint(equalTo: panelBackground.leadingAnchor, constant: 10.0),
            summaryLabel.topAnchor.constraint(equalTo: panelBackground.topAnchor, constant: 15.0),
            
            //Pages count
            summaryPagesCount.trailingAnchor.constraint(equalTo: panelBackground.trailingAnchor, constant: -10.0),
            summaryPagesCount.topAnchor.constraint(equalTo: panelBackground.topAnchor, constant: 15.0),
        ]
        
        NSLayoutConstraint.activate(constaints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
