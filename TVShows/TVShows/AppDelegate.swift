//
//  AppDelegate.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 08.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let navigationController = UINavigationController()

        if KeychainAccess.shared.retrieve() != nil {
            let storyboard = UIStoryboard(name: "Shows", bundle: .main)
            let showsViewController = storyboard.instantiateViewController(withIdentifier: "ShowsViewController") as! ShowsViewController
            navigationController.viewControllers = [showsViewController]
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: .main)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController.viewControllers = [loginViewController]
        }
        window?.rootViewController = navigationController

        return true
    }
}
