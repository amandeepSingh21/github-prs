//
//  PullRequestWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class PullRequestWireframe: TabBarInterface {
    
    private(set) weak var pullRequestsViewController: UIViewController?

    private let pullRequestDetailWireframe: PullRequestDetailWireframe
   
    
    // MARK: Public
    init(pullRequestDetailWireframe: PullRequestDetailWireframe) {
        self.pullRequestDetailWireframe = pullRequestDetailWireframe
    }
    
    func configuredViewController() -> UIViewController {
        let pullRequestsViewController = newPullRequestsViewController()
        
        let navigationController = UINavigationController(rootViewController: pullRequestsViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        defer {
            self.pullRequestsViewController = pullRequestsViewController
        }
        return navigationController
    }
    
    func showPullRequestDetailScreen() {
        guard let navigation = self.pullRequestsViewController?.navigationController else {
            return
        }
        self.pullRequestDetailWireframe.present(in: navigation)
    }
    
    // MARK: - Private
    private func newPullRequestsViewController() -> UIViewController {
        let pullRequestsController = PullRequestsController()
        return pullRequestsController
    }
   
}
