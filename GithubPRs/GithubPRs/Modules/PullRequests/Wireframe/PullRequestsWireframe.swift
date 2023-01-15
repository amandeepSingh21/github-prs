//
//  PullRequestWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

protocol PRWireframeInterface: AnyObject {
    func showDetailScreen(_ viewModel: PullRequestViewModel)
    func buildView() -> UIViewController
    init(pullRequestDetailWireframe: PRDetailWireframeInterface,
         screenType: PullRequestScreenType)
}

final class PullRequestWireframe: PRWireframeInterface {
    private(set) weak var pullRequestsController: UIViewController?
    private let screenType: PullRequestScreenType
    private let pullRequestDetailWireframe: PRDetailWireframeInterface
 
    // MARK: Public methods
    init(pullRequestDetailWireframe: PRDetailWireframeInterface,
         screenType: PullRequestScreenType) {
        self.pullRequestDetailWireframe = pullRequestDetailWireframe
        self.screenType = screenType
    }
    
    func buildView() -> UIViewController {
        let pullRequestsController = newPullRequestsViewController(self.screenType)
        defer {
            self.pullRequestsController = pullRequestsController
        }
        return pullRequestsController
    }
    
    func showDetailScreen(_ viewModel: PullRequestViewModel) {
        guard let controller = self.pullRequestsController,
              let parent = controller.parent,
              let nav = parent.navigationController
        else { return }
        
        self.pullRequestDetailWireframe.showDetailScreen(for: viewModel, in: nav)
    }
    
    // MARK: - Private
    private func newPullRequestsViewController(_ screenType: PullRequestScreenType) -> UIViewController {
        let interactor = PullRequestInteractor()
        let presenter = PullRequestPresenter(wireframe: self, interactor: interactor, screenType: screenType)
        let pullRequestsController = PullRequestsController(presenter: presenter)
        return pullRequestsController
    }
    
}
