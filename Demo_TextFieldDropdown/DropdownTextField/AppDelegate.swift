//
//  AppDelegate.swift
//  DropdownTextField
//
//  Created by Duy Tran N. VN.Danang on 12/24/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            window.makeKeyAndVisible()
            window.rootViewController = HomeViewController()
        }
        return true
    }
}
