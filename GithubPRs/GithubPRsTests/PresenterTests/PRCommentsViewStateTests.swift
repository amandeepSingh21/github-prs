//
//  PRCommentsViewStateTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import XCTest
@testable import GithubPRs

final class PRCommentsViewStateTests: XCTestCase {
    
    var presenter: PRCommentsPresenterProtocol!
    var interactor: MockPRCommentsInteractor!
    
    override func setUp() {
        interactor = MockPRCommentsInteractor()
      
        presenter = PRCommentsPresenter(wireframe: MockPRCommentsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
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
        
        presenter.load()
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
        
        presenter.load()
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
        
        presenter.load()
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
        presenter.load()
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(expectedStates, resultingStates)
    }
 
}
