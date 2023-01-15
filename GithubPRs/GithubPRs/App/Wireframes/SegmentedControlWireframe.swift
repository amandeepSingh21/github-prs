//
//  SegmentedControlWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit

protocol SegmentedControlInterface: AnyObject {
    func configuredViewController() -> UIViewController
}

class SegmentedControlWireframe: TabBarInterface {
    
    let wireFrames: [SegmentedControlInterface]
    private let title: String
    private let screenTypes: [ScreenType]

    // MARK: - Initializers
    init(_ wireFrames: SegmentedControlInterface..., screenTypes: [ScreenType], title: String) {
        self.wireFrames = wireFrames
        self.title = title
        self.screenTypes = screenTypes
    }
    
    func configuredViewController() -> UIViewController {
        let segmentedViewController = SegmentedViewController(screenTypes: screenTypes, title: title)
        segmentedViewController.viewControllers = wireFrames.map({ $0.configuredViewController() })
      
        let vc = UINavigationController(rootViewController: segmentedViewController)
        segmentedViewController.navigationController?.navigationBar.prefersLargeTitles = true
        segmentedViewController.tabBarController?.tabBar.isHidden = true
        return vc
    }
    
}
