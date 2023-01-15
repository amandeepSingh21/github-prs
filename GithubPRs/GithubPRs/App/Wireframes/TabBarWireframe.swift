//
//  TabBarWireframw.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

protocol TabBarInterface: AnyObject {
    func configuredViewController() -> UIViewController
}

class TabBarWireframe {
    let wireFrames: [TabBarInterface]
    
    // MARK: - Initializers
    init(_ wireFrames: TabBarInterface...) {
        self.wireFrames = wireFrames
    }
    
    private init() {
        self.wireFrames = [TabBarInterface]()
    }
    
    func installInto(window: UIWindow) {
        let tabBar = UITabBarController()
        tabBar.viewControllers = wireFrames.map({ $0.configuredViewController() })
        _ = tabBar.viewControllers?.map { $0.tabBarController?.tabBar.isHidden = true }
        window.rootViewController = tabBar
    }
}
