//
//  NavigationTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import XCTest
@testable import GithubPRs

final class NavigationTests: XCTestCase {

    var prContainerWireframe: MockPRContainerWireframe!
    var prWireframe: MockPullRequestWireframe!
    var prDetailWireframe: MockPRDetailWireframe!
    var prCommitsWireframe: MockPRCommitsWireframe!
    var prCommentsWireframe: MockPRCommentsWireframe!
   
    override func setUp() {
        prCommitsWireframe = MockPRCommitsWireframe()
        prCommentsWireframe = MockPRCommentsWireframe()
        prDetailWireframe = MockPRDetailWireframe(commitsWireframe: prCommitsWireframe, commentsWirefram: prCommentsWireframe, screenTypes: [PullRequestDetailScreenType.comments, PullRequestDetailScreenType.comments], title: "PR Detail")
        prWireframe = MockPullRequestWireframe(pullRequestDetailWireframe: prDetailWireframe, screenType: .open)
        prContainerWireframe = MockPRContainerWireframe(prWireframe, screenTypes: [PullRequestScreenType.open], title: "Swift")
    }
    
    func testPullRequestViewShown() {
        //assume initial view laoding after applaunch
      _ = prContainerWireframe.configuredViewController()
        XCTAssertEqual(prWireframe.isPRListScreenShown, true)
    }
    
    func testPullRequestDetailViewShown() {
      _ = prContainerWireframe.configuredViewController()
        prDetailWireframe.showDetailScreen(for: PullRequestViewModel.buildMock(), in: UINavigationController())
        XCTAssertEqual(prCommitsWireframe.isCommitModuleShown, true)
        XCTAssertEqual(prCommentsWireframe.isCommentsModuleShown, true)
    }
    
    func testCommitDetailScreenShown() {
        _ = prContainerWireframe.configuredViewController()
          prDetailWireframe.showDetailScreen(for: PullRequestViewModel.buildMock(), in: UINavigationController())
        prCommitsWireframe.showCommitDetailScreen(URL(string: "abc")!)
          XCTAssertEqual(prCommitsWireframe.isCommitDetailShown, true)
    }
    
    func testCommentDetailScreenShown() {
      _ = prContainerWireframe.configuredViewController()
        prDetailWireframe.showDetailScreen(for: PullRequestViewModel.buildMock(), in: UINavigationController())
        prCommentsWireframe.showCommentsDetailScreen(URL(string: "abc")!)
        XCTAssertEqual(prCommentsWireframe.isCommentsDetailShown, true)
    }

}
