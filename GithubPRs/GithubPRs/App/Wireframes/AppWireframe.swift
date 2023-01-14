//
//  RootRouter.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class AppWireframe {
    
    // MARK: - Properties
    private(set) weak var window: UIWindow!

    let tabBarWireframe: TabBarWireframe

    
    // MARK: - Public
    init(window: UIWindow) {
        self.window = window
        let prCommitsWireframe = PullRequestCommitsWireframe()
        let prCommentsWireframe = PullRequestCommentsWireframe()
        let pullRequestDetailWireframe = PullRequestDetailWireframe(commitsWireframe: prCommitsWireframe, commentsWireframe: prCommentsWireframe)
        let pullRequestWireframe =  PullRequestWireframe(pullRequestDetailWireframe: pullRequestDetailWireframe)
        self.tabBarWireframe = TabBarWireframe(pullRequestWireframe)
    }
    
    func installRootViewController() {
        self.tabBarWireframe.installInto(window: self.window)
    }

}

