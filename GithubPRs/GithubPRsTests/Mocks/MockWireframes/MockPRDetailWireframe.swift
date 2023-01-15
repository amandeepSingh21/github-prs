//
//  MockPRDetailWireframeInterface.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit
@testable import GithubPRs

final class MockPRDetailWireframe: PRDetailWireframeInterface {
    
    let commitsWireframe: PRCommitsWireframeInterface
    let commentsWirefram: PRCommentsWireframeInterface
    let screenTypes: [ScreenType]
    let title: String
    
    func showDetailScreen(for viewModel: PullRequestViewModel, in navigationController: UINavigationController) {
       _ = self.commitsWireframe.buildView(viewModel)
       _ = self.commentsWirefram.buildView(viewModel)
    }
    
    init(commitsWireframe: PRCommitsWireframeInterface, commentsWirefram: PRCommentsWireframeInterface, screenTypes: [ScreenType], title: String) {
        self.commentsWirefram = commentsWirefram
        self.commitsWireframe = commitsWireframe
        self.screenTypes = screenTypes
        self.title = title
    }
}

