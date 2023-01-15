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
    private  let pullRequestDetailWireframe: PullRequestDetailWireframe
 
   
    // MARK: Public
    init(pullRequestDetailWireframe: PullRequestDetailWireframe,
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
    
    func showPullRequestDetailScreen() {
        guard let controller = self.pullRequestsController, let parent = controller.parent else {
            return
        }
       // container.showPullRequestDetailScreen()
    }
    
    // MARK: - Private
    private func newPullRequestsViewController(_ screenType: PullRequestScreenType) -> UIViewController {
        let interactor = PullRequestInteractor()
        let presenter = PullRequestPresenter(wireframe: self, interactor: interactor, screenType: screenType)
        let pullRequestsController = PullRequestsController(presenter: presenter)
        return pullRequestsController
    }
    
}
