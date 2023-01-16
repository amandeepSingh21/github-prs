//
//  AppDelegate.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appWireframe: AppWireframe!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.appWireframe = AppWireframe(window: self.window!)
        self.appWireframe.installRootViewController()
        window?.tintColor = .systemGreen
        window?.makeKeyAndVisible()
        return true
    }
}

