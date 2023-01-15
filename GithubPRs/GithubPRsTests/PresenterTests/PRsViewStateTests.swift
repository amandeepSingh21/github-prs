//
//  GithubPRsTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 14/01/23.
//

import XCTest
@testable import GithubPRs

final class PRsViewStateTests: XCTestCase {
    
    var presenter: PullRequestPresenter!
    var interactor: MockPullRequestInteractor!
    
    override func setUp() {
        interactor = MockPullRequestInteractor()
       
        presenter = PullRequestPresenter(wireframe: MockPullRequestWireframe.build(),
                                         interactor: interactor,
                                         screenType: .closed)
    }
    
    func testURLPath() {
        presenter.load(organisation: "google", repo: "android")
        XCTAssertEqual(presenter.organisationName, "google")
        XCTAssertEqual(presenter.repoName, "android")
    }
    
    func testScreenType() {
        XCTAssertEqual(presenter.screenType, .closed)
    }
    
    func testEmptyViewState() {
        let expectation = self.expectation(description: "ViewState should be set to empty.")

        interactor.viewStateToTest = PullRequestViewState.noResultsFound
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), PullRequestViewState.noResultsFound]
        expectation.expectedFulfillmentCount = expectedStates.count
        var resultingStates: [PullRequestViewState] = []
        presenter.viewState.bind { (state) in
            resultingStates.append(state)
            expectation.fulfill()
        }

        presenter.load(organisation: "swfit", repo: "repo")
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(expectedStates, resultingStates)
    }

    func testNonEmptyViewState() {
        let expectation = self.expectation(description: "ViewState should be set to non empty.")

        interactor.viewStateToTest = PullRequestViewState.loaded
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded]
        expectation.expectedFulfillmentCount = expectedStates.count
        var resultingStates: [PullRequestViewState] = []
        presenter.viewState.bind { (state) in
            resultingStates.append(state)
            expectation.fulfill()
        }

        presenter.load(organisation: "swfit", repo: "repo")
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(expectedStates, resultingStates)
    }

    func testErrorViewState() {
        let expectation = self.expectation(description: "ViewState should be set to error")

        interactor.viewStateToTest = PullRequestViewState.error(.init(""))
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), .error(.init(""))]
        expectation.expectedFulfillmentCount = expectedStates.count
        var resultingStates: [PullRequestViewState] = []
        presenter.viewState.bind { (state) in
            resultingStates.append(state)
            expectation.fulfill()
        }

        presenter.load(organisation: "swfit", repo: "repo")
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(expectedStates, resultingStates)
    }

    func testNotSearchedViewState() {
        let expectation = self.expectation(description: "ViewState should be set to not searched")

        interactor.viewStateToTest = .notLoaded
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded]
        expectation.expectedFulfillmentCount = expectedStates.count
        var resultingStates: [PullRequestViewState] = []
        presenter.viewState.bind { (state) in
            resultingStates.append(state)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(expectedStates, resultingStates)
    }

    func testSearchingViewState() {
        let expectation = self.expectation(description: "ViewState should be set to searching")

        interactor.viewStateToTest = .loading("")
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded,PullRequestViewState.loading("Yo")]
        expectation.expectedFulfillmentCount = expectedStates.count
        var resultingStates: [PullRequestViewState] = []
        presenter.viewState.bind { (state) in
            resultingStates.append(state)
            expectation.fulfill()
        }
        presenter.load(organisation: "swfit", repo: "repo")
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(expectedStates, resultingStates)
    }
    
    
}
