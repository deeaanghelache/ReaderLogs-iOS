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
    let nameLabelView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.borderWidth = 2.0
        profileImageView.parentViewController = self
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        profileImageView.tintColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        view.addSubview(profileImageView)
        
        // MARK: Constraints
//        let constraints = [
//
//        ]
//
//        NSLayoutConstraint.activate(constraints)
    }
}
