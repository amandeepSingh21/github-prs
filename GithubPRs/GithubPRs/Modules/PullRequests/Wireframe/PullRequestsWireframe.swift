//
//  PullRequestWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

final class PullRequestWireframe: SegmentedControlInterface {
    
    private(set) weak var pullRequestsController: UIViewController?
    private  let screenType: PullRequestScreenType
    private  let pullRequestDetailWireframe: PullRequestDetailWireframeInterface
 
   
    // MARK: Public
    init(pullRequestDetailWireframe: PullRequestDetailWireframeInterface,
         screenType: PullRequestScreenType) {
        self.pullRequestDetailWireframe = pullRequestDetailWireframe
        self.screenType = screenType
    }
    
    func configuredViewController() -> UIViewController {
        let pullRequestsController = newPullRequestsViewController(self.screenType)
        defer {
            self.pullRequestsController = pullRequestsController
        }
        return pullRequestsController
    }
    
    func showPullRequestDetailScreen(_ pr: PullRequestViewModel) {
        guard let controller = self.pullRequestsController,
              let parent = controller.parent,
              let nav = parent.navigationController
        else { return }
        
        self.pullRequestDetailWireframe.showDetailScreen(for: pr, in: nav)
    }
    
    // MARK: - Private
    private func newPullRequestsViewController(_ screenType: PullRequestScreenType) -> UIViewController {
        let interactor = PullRequestInteractor()
        let presenter = PullRequestPresenter(wireframe: self, interactor: interactor, screenType: screenType)
        let pullRequestsController = PullRequestsController(presenter: presenter)
        return pullRequestsController
    }
    
}
