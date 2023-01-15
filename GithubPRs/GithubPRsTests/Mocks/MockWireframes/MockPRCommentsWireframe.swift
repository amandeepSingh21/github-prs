//
//  MocPRCommentsWireframe.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit
@testable import GithubPRs

final class MockPRCommentsWireframe: PRCommentsWireframeInterface {
    var isCommentsModuleShown = false
    var isCommentsDetailShown = false
    
    func buildView(_ pullRequest: GithubPRs.PullRequestViewModel) -> UIViewController {
        self.isCommentsModuleShown = true
        return UIViewController()
    }
    
    func showCommentsDetailScreen(_ url: URL) {
         isCommentsDetailShown = true
    }
    
}


