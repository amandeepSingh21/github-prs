//
//  PullRequestCommentsWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit
import SafariServices

protocol PRCommentsWireframeInterface: AnyObject {
    func buildView(_ pullRequest: PullRequestViewModel) -> UIViewController
    func showCommentsDetailScreen(_ url: URL)
}

final class PRCommentsWireframe: PRCommentsWireframeInterface {
    
    private(set) weak var prCommentsController: UIViewController?
 
    //MARK: Public methods
    func buildView(_ pullRequest: PullRequestViewModel) -> UIViewController {
        let prCommentsController = newPRCommentsControllerController(pullRequest)
        defer {
            self.prCommentsController = prCommentsController
        }
        return prCommentsController
    }
    
    func showCommentsDetailScreen(_ url: URL) {
        guard let controller = self.prCommentsController else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.modalPresentationStyle = .pageSheet
        controller.present(vc, animated: true)
    }
    
    //MARK: - Private
    private func newPRCommentsControllerController(_ pullRequest: PullRequestViewModel) -> UIViewController {
        let interactor = PRCommentsInteractor()
        let presenter = PRCommentsPresenter(wireframe: self,
                                            interactor: interactor,
                                            pullRequest: pullRequest)
        let pullRequestsController = PRCommentsController(presenter: presenter)
        return pullRequestsController
    }
}
