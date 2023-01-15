//
//  PullRequestDetailWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

protocol PullRequestDetailWireframeInterface: AnyObject {
    func showDetailScreen(for pr: PullRequestViewModel, in navigationController: UINavigationController)
}

class PullRequestDetailWireframe: PullRequestDetailWireframeInterface {
    
    let commitsWireframe: PullRequestCommitsWireframe
    let commentsWirefram: PRCommentsWireframe
    private let title: String
    private let screenTypes: [ScreenType]

    // MARK: - Initializers
    init(commitsWireframe: PullRequestCommitsWireframe,
         commentsWirefram: PRCommentsWireframe,
         screenTypes: [ScreenType],
         title: String) {
        self.commitsWireframe = commitsWireframe
        self.commentsWirefram = commentsWirefram
        self.title = title
        self.screenTypes = screenTypes
    }
    
    func showDetailScreen(for pr: PullRequestViewModel, in navigationController: UINavigationController)  {
        let segmentedViewController = SegmentedViewController(screenTypes: screenTypes, title: title)
       // let commitsVC = self.commitsWireframe.configuredViewController()
        let commentsVC = self.commentsWirefram.configuredViewController(pr)
        segmentedViewController.viewControllers = [commentsVC]
        navigationController.pushViewController(segmentedViewController, animated: true)
    }
}
