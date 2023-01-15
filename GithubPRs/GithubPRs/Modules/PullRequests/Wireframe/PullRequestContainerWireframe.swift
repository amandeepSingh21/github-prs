//
//  SegmentedControlWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit

final class PullRequestContainerWireframe: TabBarInterface {
    private let wireFrames: [PRWireframeInterface]
    private let title: String
    private let screenTypes: [ScreenType]

    //MARK: - Public methods
    init(_ wireFrames: PRWireframeInterface..., screenTypes: [ScreenType], title: String) {
        self.wireFrames = wireFrames
        self.title = title
        self.screenTypes = screenTypes
    }
    
    func configuredViewController() -> UIViewController {
        let segmentedViewController = SegmentedViewController(screenTypes: screenTypes, title: title)
        segmentedViewController.viewControllers = wireFrames.map({ $0.buildView() })
        let vc = UINavigationController(rootViewController: segmentedViewController)
        segmentedViewController.navigationController?.navigationBar.prefersLargeTitles = true
        return vc
    }
    
}
