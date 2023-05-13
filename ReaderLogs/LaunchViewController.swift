//
//  LaunchViewController.swift
//  ReaderLogs
//
//  Created by Mara Dascalu on 13.05.2023.
//

import FirebaseAuth
import FirebaseAuthUI
import NVActivityIndicatorView
import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var loader: NVActivityIndicatorView!
    
    private var authHandler: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        loader.color = UIColor.blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authHandler = Auth.auth().addStateDidChangeListener { auth, user in

            if user != nil {
                self.performSegue(withIdentifier: "tabBarControllerSegueId", sender: nil)
                return
            }

            guard let window = self.view.window, let authViewController = FUIAuth.defaultAuthUI()?.authViewController() else {
                return
            }

            window.rootViewController = authViewController
            UIView.transition(with: window, duration: 0.3, animations: {})
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loader.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(authHandler!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
