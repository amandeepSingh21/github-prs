//
//  MockPRCommitWireframe.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit
@testable import GithubPRs

final class MockPRCommitsWireframe: PRCommitsWireframeInterface {
    var isCommitModuleShown = false
    var isCommitDetailShown = false
    
    func buildView(_ pullRequest: GithubPRs.PullRequestViewModel) -> UIViewController {
        self.isCommitModuleShown = true
        return UIViewController()
    }
    
    func showCommitDetailScreen(_ url: URL) {
        isCommitDetailShown = true
    }
}

