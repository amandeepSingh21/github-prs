//
//  NoInternetTest.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import XCTest

@testable import GithubPRs

final class NoInternetTest: XCTestCase {
    
    var presenter: PRCommentsPresenterProtocol!
    var interactor: PRCommentsInteractorProtocol!
    
    
    func testNoInternet() {
        let expectation = XCTestExpectation(description: #function)
        let reachability = MockReachibility(isConnectedToNetwork: false)
        let network = NetworkManager(session: MockGoodSession(), reachability: reachability)
        
        interactor = PRCommentsInteractor(networkManager: network)
        presenter =  PRCommentsPresenter(wireframe: MockPRCommentsWireframe(),
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
        XCTAssert(error == "Internet is not connected", "No Internet error should occur")
        
    }
    
}
   
    





