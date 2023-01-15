//
//  PaginationTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import XCTest
@testable import GithubPRs

final class PaginationTests: XCTestCase {
    
    var presenter: PRCommentsPresenterProtocol!
    var interactor: MockPRCommentsInteractor!
    
    override func setUp() {
        interactor = MockPRCommentsInteractor()
      
        presenter = PRCommentsPresenter(wireframe: MockPRCommentsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
    }
    
    func testLoadOnce() {
        let expectation = self.expectation(description: "Count should be 2")
        
        interactor.viewStateToTest = PullRequestViewState.loaded
      
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded]
        expectation.expectedFulfillmentCount = expectedStates.count

        presenter.viewState.bind { (state) in
            expectation.fulfill()
        }
        presenter.load()
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(presenter.paginator?.page, 2)
    }
    
    func testLoadMore() {
        let expectation = self.expectation(description: "Count should be 3")
        
        interactor.viewStateToTest = PullRequestViewState.loaded
      
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded,PullRequestViewState.loaded]
        expectation.expectedFulfillmentCount = expectedStates.count

        presenter.viewState.bind { (state) in
            expectation.fulfill()
        }
        presenter.load()
        presenter.loadMore()
       
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(presenter.paginator?.page, 3)
    }
    
    func testRefresh() {
        let expectation = self.expectation(description: "Count should be go back to 2")
        
        interactor.viewStateToTest = PullRequestViewState.loaded
      
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded,PullRequestViewState.loaded]
        expectation.expectedFulfillmentCount = expectedStates.count

        presenter.viewState.bind { (state) in
            expectation.fulfill()
        }
        presenter.load()
        presenter.load()
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(presenter.paginator?.page, 2)
    }
    
    func testQueryChange() {
        let expectation = self.expectation(description: "Count should be go back to 2")
        
        interactor.viewStateToTest = PullRequestViewState.loaded
      
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded, PullRequestViewState.loaded, PullRequestViewState.loading("Yo"), PullRequestViewState.loaded]
        expectation.expectedFulfillmentCount = expectedStates.count

        presenter.viewState.bind { (state) in
            expectation.fulfill()
        }
        presenter.load()
        presenter.loadMore()
        presenter.load()
       
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(presenter.paginator?.page, 2)
    }
    
    func testShouldNotPaginateWhileOtherRequestInProgress() {
        let expectation = self.expectation(description: "ViewState should be set to non empty.")

        interactor.viewStateToTest = PullRequestViewState.loaded
        interactor.isAsync = true //Mocking production API delay
        let expectedStates: [PullRequestViewState] = [PullRequestViewState.notLoaded, PullRequestViewState.loading("Yo"),  PullRequestViewState.loaded]
        expectation.expectedFulfillmentCount = expectedStates.count
        var resultingStates: [PullRequestViewState] = []
        presenter.viewState.bind { (state) in
            resultingStates.append(state)
            expectation.fulfill()
        }

        presenter.load()
        presenter.loadMore()
        presenter.loadMore()
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(presenter.paginator?.page, 2)
    }
 
}
