//
//  MockPullRequestWireframe.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit
@testable import GithubPRs

final class MockPullRequestWireframe: PRWireframeInterface {
    
    let pullRequestDetailWireframe: PRDetailWireframeInterface
    let screenType: PullRequestScreenType
    var isPRListScreenShown = false
    
   
    init(pullRequestDetailWireframe: PRDetailWireframeInterface, screenType: PullRequestScreenType) {
        self.pullRequestDetailWireframe = pullRequestDetailWireframe
        self.screenType = screenType
    }
    
    func showDetailScreen(_ viewModel: PullRequestViewModel) {
        pullRequestDetailWireframe.showDetailScreen(for: viewModel, in: UINavigationController())
    }
    
    func buildView() -> UIViewController {
        self.isPRListScreenShown = true
        return UIViewController()
        
    }
        

    static func build() -> MockPullRequestWireframe  {
        let commitsWireframe = MockPRCommitsWireframe()
        let commentsWireframe = MockPRCommentsWireframe()
        let detailWireframe = MockPRDetailWireframe(commitsWireframe: commitsWireframe,
                                                    commentsWirefram: commentsWireframe,
                                                    screenTypes: [PullRequestScreenType.open, PullRequestScreenType.closed],
                                                    title: "Swift")
        let wireframe = MockPullRequestWireframe(pullRequestDetailWireframe: detailWireframe, screenType: .open)
        return wireframe
    }
}

