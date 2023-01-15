//
//  MockAPIErrorSession.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
@testable import GithubPRs

class MockAPIErrorSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let data = MockJsonLoader().loadBadJSON(request: request)
        let response = MockResponseLoader().loadBadResponse(request: request)
        completionHandler(data, response, nil)
        return MockDataTask()
    }
}
