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
        let prCommitsWireframe = PRCommitsWireframe()
        let prCommentsWireframe = PRCommentsWireframe()
        let pullRequestDetailWireframe = PullRequestDetailWireframe(commitsWireframe: prCommitsWireframe,
                                                                    commentsWirefram: prCommentsWireframe,
                                                                    screenTypes: [PullRequestDetailScreenType.comments, PullRequestDetailScreenType.commits],
                                                                    title: "PR Details")
       
        let openPRWireframe: SegmentedControlInterface = PullRequestWireframe(pullRequestDetailWireframe: pullRequestDetailWireframe, screenType: .open)
        let closedPRWireframe: SegmentedControlInterface = PullRequestWireframe(pullRequestDetailWireframe: pullRequestDetailWireframe, screenType: .closed)
       
        
        let segmentedControlWireframe = SegmentedControlWireframe(openPRWireframe,closedPRWireframe, screenTypes: [PullRequestScreenType.open, PullRequestScreenType.closed], title: "Swift")
       
        self.tabBarWireframe = TabBarWireframe(segmentedControlWireframe)
    }
    
    func installRootViewController() {
        self.tabBarWireframe.installInto(window: self.window)
    }

}

