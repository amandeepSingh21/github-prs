//
//  MockPRCommitsInteractor.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
@testable import GithubPRs

class MockPRCommitsInteractor: PRCommitsInteractorProtocol {
    
    var viewStateToTest: PullRequestViewState = .noResultsFound
    var isAsync = false
    
    func load(_ request: Request, completion: @escaping PRCommitAPIResult) {
        if isAsync {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.proccess(request, completion: completion)
            })
        } else {
            self.proccess(request, completion: completion)
        }
    }
    
    func cancelRequest() {}
    
    private func proccess(_ request: Request, completion: @escaping PRCommitAPIResult) {
        switch self.viewStateToTest {
        case .noResultsFound:
            let mockData = MockCommitsData.getEmpty()
            completion(.success(mockData))
        case .loaded:
            let mockData = MockCommitsData.getNonEmpty()
            completion(.success(mockData))
        case .error:
            completion(.failure(.init("Something went wrong")))
        default:
            break
        }
    }
}
                                          

