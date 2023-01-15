//
//  CommitsNetworkingTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
import XCTest
@testable import GithubPRs

final class CommitsNetworkingTests: XCTestCase {
    
    var presenter: PRCommitsPresenter!
    var interactor: PRCommitsInteractor!
    
    
    func testHappyPath() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockGoodSession(), reachability: reachability)
        
        interactor = PRCommitsInteractor(networkManager: network)
        presenter =  PRCommitsPresenter(wireframe: MockPRCommitsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
        presenter.load()
        presenter.viewState.bind { state in
            if state == .loaded {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(presenter.commits.count == 1, "PR list is empty")
        
    }
    
    //Basic URLSession Error
    func testUnHappyPath() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockBadSession(), reachability: reachability)
        
        interactor = PRCommitsInteractor(networkManager: network)
        presenter =  PRCommitsPresenter(wireframe: MockPRCommitsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
        presenter.load()
        var error: NSError?
        presenter.viewState.bind { state in
            if case .error(let value) = state {
                error = value.networkError?.urlSessionError.underlyingError
                expectation.fulfill()
                
            }
             
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(error?.code == 100, "Session error should occur with 100 code")
        
    }
    
    func testAPIError() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockAPIErrorSession(), reachability: reachability)
        
        interactor = PRCommitsInteractor(networkManager: network)
        presenter =  PRCommitsPresenter(wireframe: MockPRCommitsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
        presenter.load()
        var error: String?
        presenter.viewState.bind { state in
            if case .error(let value) = state {
                error = value.message
                expectation.fulfill()
                
            }
             
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(error == "Server Error", "API error should occur")
        
    }
    
    func testBadStatusCode() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockBadStatusCodeSession(), reachability: reachability)
        
        interactor = PRCommitsInteractor(networkManager: network)
        presenter =  PRCommitsPresenter(wireframe: MockPRCommitsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
        presenter.load()
        var code: Int?
        presenter.viewState.bind { state in
            if case .error(let value) = state {
                code = value.networkError?.urlSessionError.httpURLResponse?.statusCode
                expectation.fulfill()
                
            }
             
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(code == 400, "API error should occur")
        
    }
    
    func testRateLimit() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockRateLimitedSession(), reachability: reachability)
        
        interactor = PRCommitsInteractor(networkManager: network)
        presenter =  PRCommitsPresenter(wireframe: MockPRCommitsWireframe(),
                                        interactor: interactor,
                                        pullRequest: PullRequestViewModel.buildMock())
        presenter.load()
        var error: String = ""
        presenter.viewState.bind { state in
            if case .error(let value) = state {
                error = value.message
                expectation.fulfill()
                
            }
             
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(error.contains("Rate limited"), "API error should occur")
        
    }
}

   
    





