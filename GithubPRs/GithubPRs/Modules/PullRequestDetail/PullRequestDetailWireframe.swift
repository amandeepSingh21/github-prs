//
//  PullRequestDetailWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

protocol PRDetailWireframeInterface: AnyObject {
    func showDetailScreen(for viewModel: PullRequestViewModel, in navigationController: UINavigationController)
    init(commitsWireframe: PRCommitsWireframeInterface,
         commentsWirefram: PRCommentsWireframeInterface,
         screenTypes: [ScreenType],
         title: String)
}

final class PullRequestDetailWireframe: PRDetailWireframeInterface {
    private let commitsWireframe: PRCommitsWireframeInterface
    private let commentsWirefram: PRCommentsWireframeInterface
    private let title: String
    private let screenTypes: [ScreenType]

    // MARK: - Public
    init(commitsWireframe: PRCommitsWireframeInterface,
         commentsWirefram: PRCommentsWireframeInterface,
         screenTypes: [ScreenType],
         title: String) {
        self.commitsWireframe = commitsWireframe
        self.commentsWirefram = commentsWirefram
        self.title = title
        self.screenTypes = screenTypes
    }
    
    func showDetailScreen(for pr: PullRequestViewModel, in navigationController: UINavigationController)  {
        let segmentedViewController = SegmentedViewController(screenTypes: screenTypes, title: title)
        let commitsVC = self.commitsWireframe.buildView(pr)
        let commentsVC = self.commentsWirefram.buildView(pr)
        segmentedViewController.viewControllers = [commentsVC, commitsVC]
        navigationController.pushViewController(segmentedViewController, animated: true)
    }
}
