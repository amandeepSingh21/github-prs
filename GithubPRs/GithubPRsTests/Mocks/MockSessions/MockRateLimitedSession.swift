//
//  MockRateLimitSession.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
@testable import GithubPRs

class MockRateLimitedSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let response = MockResponseLoader().loadRateLimitedResponse(request: request)
        let data = MockJsonLoader().loadBadJSON(request: request)
        completionHandler(data, response, nil)
        return MockDataTask()
    }
}
