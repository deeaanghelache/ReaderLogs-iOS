//
//  CustomAuthPickerViewController.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 13.05.2023.
//

import FirebaseAuthUI
import UIKit

class CustomAuthPickerViewController: FUIAuthPickerViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.title = "Sign In"
        self.navigationItem.setLeftBarButton(nil, animated: false)
    }
}
