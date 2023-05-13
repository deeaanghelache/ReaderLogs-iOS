//
//  AppDelegate.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 01.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseGoogleAuthUI
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuthUI
import FirebaseEmailAuthUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FUIAuthDelegate {

    var window: UIWindow?
    var ref: DatabaseReference!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self

        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://example.appspot.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setAndroidPackageName("com.firebase.example", installIfNotAvailable: false, minimumVersion: "12")

        authUI?.providers = [
            FUIGoogleAuth(authUI: authUI!),
            FUIEmailAuth(
                authAuthUI: authUI!,
                signInMethod: EmailPasswordAuthSignInMethod,
                forceSameDevice: true,
                allowNewEmailAccounts: true,
                actionCodeSetting: actionCodeSettings
            ),
        ]

        ref = Database.database(url: "https://readerlogs-ios-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: UIApplicationDelegate

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {

        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }

        // other URL handling goes here.
        return false
    }

    // MARK: FUIAuthDelegate

    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        return CustomAuthPickerViewController(authUI: authUI)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {

        if let error = error {
            NSLog("Encountered error during sign in: %@", error.localizedDescription)
            return
        }

        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()

        UIView.transition(with: window, duration: 0.3, animations: {})
    }
}
