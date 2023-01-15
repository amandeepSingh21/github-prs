//
//  MockBadSession.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
@testable import GithubPRs

///Happy path with URLSession error
class MockBadSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let response = MockResponseLoader().loadGoodResponse(request: request)
        let error = MockErrorLoader().getError(request: request)
        completionHandler(nil, response, error)
        return MockDataTask()
    }
}
