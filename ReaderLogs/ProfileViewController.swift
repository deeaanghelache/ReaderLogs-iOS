//
//  ProfileViewController.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 02.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let labelView = UILabel()
    let profileImageView = ProfileIconView(frame: CGRect(x: 125, y: 125, width: 150, height: 150))
    let nameView = UILabel()
    let usernameView = UILabel()
    let emailView = UILabel()
    let stackView = UIStackView()
    let challengeLabel = UILabel()
    let line1 = UILabel()
    let line2 = UILabel()
    let line3 = UILabel()
    let divider = UILabel()
    let horizontalStack1 = UIStackView()
    let horizontalStack2 = UIStackView()
    let horizontalStack3 = UIStackView()
    let nameIcon = UIImageView()
    let usernameIcon = UIImageView()
    let emailIcon = UIImageView()
    let challengeButton = UIButton()
    var challenge = false
    var maxNumberOfBooks : Int = 0
    var currentNumberOfBooksRead : Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        
        labelView.backgroundColor = .systemBlue
        labelView.textColor = .black
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.layer.cornerRadius = 180
        labelView.clipsToBounds = true
        view.addSubview(labelView)
        
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.borderWidth = 2.0
        profileImageView.parentViewController = self
        profileImageView.backgroundColor = .white
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        profileImageView.tintColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        view.addSubview(profileImageView)
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        view.addSubview(stackView)
        
        divider.text = "----"
        divider.textColor = .white
        stackView.addArrangedSubview(divider)
        
        horizontalStack1.axis = .horizontal
        horizontalStack1.distribution = .fillProportionally
        horizontalStack1.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack1.spacing = 10.0
        stackView.addArrangedSubview(horizontalStack1)
        
        nameIcon.image = UIImage(systemName: "person")
        nameIcon.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        horizontalStack1.addArrangedSubview(nameIcon)
        
        nameView.text = "Popescu Ion"
        nameView.numberOfLines = 1
        nameView.font = UIFont.systemFont(ofSize: 18.0)
        horizontalStack1.addArrangedSubview(nameView)
            
        line1.backgroundColor = .lightGray
        line1.layer.borderColor = UIColor.gray.cgColor
        line1.layer.borderWidth = 1.5
        line1.translatesAutoresizingMaskIntoConstraints = false
        line1.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(line1)
        
        horizontalStack2.axis = .horizontal
        horizontalStack2.distribution = .fillProportionally
        horizontalStack2.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack2.spacing = 10.0
        stackView.addArrangedSubview(horizontalStack2)
        
        usernameIcon.image = UIImage(systemName: "at")
        usernameIcon.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        horizontalStack2.addArrangedSubview(usernameIcon)
        
        usernameView.text = "username"
        usernameView.font = UIFont.systemFont(ofSize: 18.0)
        horizontalStack2.addArrangedSubview(usernameView)
        
        line2.backgroundColor = .lightGray
        line2.layer.borderColor = UIColor.gray.cgColor
        line2.layer.borderWidth = 1.5
        line2.translatesAutoresizingMaskIntoConstraints = false
        line2.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(line2)
        
        horizontalStack3.axis = .horizontal
        horizontalStack3.distribution = .fillProportionally
        horizontalStack3.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack3.spacing = 10.0
        stackView.addArrangedSubview(horizontalStack3)
        
        emailIcon.image = UIImage(systemName: "envelope")
        emailIcon.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        horizontalStack3.addArrangedSubview(emailIcon)
        
        emailView.text = "email"
        emailView.font = UIFont.systemFont(ofSize: 18.0)
        horizontalStack3.addArrangedSubview(emailView)
        
        line3.backgroundColor = .lightGray
        line3.layer.borderColor = UIColor.gray.cgColor
        line3.layer.borderWidth = 1.5
        line3.translatesAutoresizingMaskIntoConstraints = false
        line3.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(line3)
    
        if (challenge) {
            challengeLabel.text = "You have read \(currentNumberOfBooksRead)/\(maxNumberOfBooks) books this year!"
            challengeLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            challengeLabel.textAlignment = .center
            challengeLabel.textColor = .systemBlue
            stackView.addArrangedSubview(challengeLabel)
        } else {
            challengeButton.setTitle("Add a challenge", for: .normal)
            challengeButton.backgroundColor = .systemGreen
            challengeButton.layer.cornerRadius = 5.0
            challengeButton.addTarget(self, action: #selector(addChallenge), for: .touchUpInside)
            stackView.addArrangedSubview(challengeButton)
        }
        
        // MARK: Constraints
        let constraints = [
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50.0),
            labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50.0),
            labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: -100.0),
            labelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -550.0),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            stackView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 0.0),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -230.0),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func addChallenge(sender: UIButton!) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Set your reading challenge", message: "How many books would you like to read?", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Number of books"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button
            if let inputNumber = alertController.textFields![0].text {
                if let number = Int(inputNumber) {
                    if number > 0 {
                        self.maxNumberOfBooks = number
                        self.challenge = true
                        self.stackView.removeArrangedSubview(self.challengeButton)
                        self.challengeButton.removeFromSuperview()
                        self.viewDidLoad()
                    }
                } else {
                    self.maxNumberOfBooks = 0
                }
                print(self.maxNumberOfBooks)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
}
