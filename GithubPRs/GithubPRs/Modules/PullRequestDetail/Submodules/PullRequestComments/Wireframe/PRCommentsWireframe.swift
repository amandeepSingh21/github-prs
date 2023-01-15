//
//  PullRequestCommentsWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

final class PRCommentsWireframe {
    
    private(set) weak var prCommentsController: UIViewController?
 
    // MARK: Public
    init() {}
    
    func configuredViewController(_ pullRequest: PullRequestViewModel) -> UIViewController {
        let prCommentsController = newPRCommentsControllerController(pullRequest)
        defer {
            self.prCommentsController = prCommentsController
        }
        return prCommentsController
    }
    
    func showPullRequestDetailScreen() {
        guard let controller = self.prCommentsController, let parent = controller.parent else {
            return
        }
       // container.showPullRequestDetailScreen()
    }
    
    // MARK: - Private
    private func newPRCommentsControllerController(_ pullRequest: PullRequestViewModel) -> UIViewController {
        let interactor = PRCommentsInteractor()
        let presenter = PRCommentsPresenter(wireframe: self,
                                            interactor: interactor,
                                            pullRequest: pullRequest)
        let pullRequestsController = PRCommentsController(presenter: presenter)
        return pullRequestsController
    }
    
}
