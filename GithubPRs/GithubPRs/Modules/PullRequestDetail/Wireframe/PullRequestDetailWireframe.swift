//
//  PullRequestDetailWireframe.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

final class PullRequestDetailWireframe {
    private let commitsWireframe: PullRequestCommitsWireframe
    private let commentsWireframe: PullRequestCommentsWireframe
    
    private(set) weak var pullRequestDetailController: UIViewController?
    
    init(commitsWireframe: PullRequestCommitsWireframe, commentsWireframe: PullRequestCommentsWireframe) {
        self.commitsWireframe = commitsWireframe
        self.commentsWireframe = commentsWireframe
    }
    
    func showCommitsScreen() {
        guard let navigation = self.pullRequestDetailController?.navigationController else {
            return
        }
    }
    
    func showCommentsScreen() {
        guard let navigation = self.pullRequestDetailController?.navigationController else {
            return
        }
    }
    
    func present(in navigation: UINavigationController) {
        
    }
}
