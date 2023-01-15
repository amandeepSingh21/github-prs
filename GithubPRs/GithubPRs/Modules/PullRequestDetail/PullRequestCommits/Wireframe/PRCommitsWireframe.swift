//
//  PullRequestCommitsWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import SafariServices

protocol PRCommitsWireframeInterface: AnyObject {
    func buildView(_ pullRequest: PullRequestViewModel) -> UIViewController
    func showCommentsDetailScreen(_ url: URL)
}

final class PRCommitsWireframe: PRCommitsWireframeInterface {
    private(set) weak var prCommitsController: UIViewController?
 
    // MARK: Public methods
    func buildView(_ pullRequest: PullRequestViewModel) -> UIViewController {
        let prCommitsController = newPRCommitControllerController(pullRequest)
        defer {
            self.prCommitsController = prCommitsController
        }
        return prCommitsController
    }
    
    func showCommentsDetailScreen(_ url: URL) {
        guard let controller = self.prCommitsController else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.modalPresentationStyle = .pageSheet
        controller.present(vc, animated: true)
    }
    
    // MARK: - Private
    private func newPRCommitControllerController(_ pullRequest: PullRequestViewModel) -> UIViewController {
        let interactor = PRCommitsInteractor()
        let presenter = PRCommitsPresenter(wireframe: self,
                                            interactor: interactor,
                                            pullRequest: pullRequest)
        let vc = PRCommitsController(presenter: presenter)
        return vc
    }
}
