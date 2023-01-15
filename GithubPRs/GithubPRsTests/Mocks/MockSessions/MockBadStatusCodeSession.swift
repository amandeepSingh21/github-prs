//
//  MockBadStatusCodeSession.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
@testable import GithubPRs

///For e.g 400. No data. No error.
class MockBadStatusCodeSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let response = MockResponseLoader().loadBadResponse(request: request)
        completionHandler(nil, response, nil)
        return MockDataTask()
    }
}
