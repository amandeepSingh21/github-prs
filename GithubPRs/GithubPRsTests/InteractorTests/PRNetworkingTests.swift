//
//  NetworkingTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import XCTest
@testable import GithubPRs

final class PRNetworkingTests: XCTestCase {
    
    var presenter: PullRequestPresenterProtocol!
    var interactor: PullRequestInteractorProtocol!
    
    
    func testHappyPath() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockGoodSession(), reachability: reachability)
        
        interactor = PullRequestInteractor(networkManager: network)
        
        
        presenter = PullRequestPresenter(wireframe: MockPullRequestWireframe.build(),
                                         interactor: interactor,
                                         screenType: .closed)
        presenter.load(organisation: "apple", repo: "swift")
        presenter.viewState.bind { state in
            if state == .loaded {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(presenter.pullRequests.count == 10, "PR list is empty")
        
    }
    
    //Basic URLSession Error
    func testUnHappyPath() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: true)
        let network = NetworkManager(session: MockBadSession(), reachability: reachability)
        
        interactor = PullRequestInteractor(networkManager: network)
        
        
        presenter = PullRequestPresenter(wireframe: MockPullRequestWireframe.build(),
                                         interactor: interactor,
                                         screenType: .closed)
        presenter.load(organisation: "apple", repo: "swift")
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
        
        interactor = PullRequestInteractor(networkManager: network)
        
        
        presenter = PullRequestPresenter(wireframe: MockPullRequestWireframe.build(),
                                         interactor: interactor,
                                         screenType: .closed)
        presenter.load(organisation: "apple", repo: "swift")
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
        
        interactor = PullRequestInteractor(networkManager: network)
        
        
        presenter = PullRequestPresenter(wireframe: MockPullRequestWireframe.build(),
                                         interactor: interactor,
                                         screenType: .closed)
        presenter.load(organisation: "apple", repo: "swift")
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
        
        interactor = PullRequestInteractor(networkManager: network)
        
        
        presenter = PullRequestPresenter(wireframe: MockPullRequestWireframe.build(),
                                         interactor: interactor,
                                         screenType: .closed)
        presenter.load(organisation: "apple", repo: "swift")
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

   
    





