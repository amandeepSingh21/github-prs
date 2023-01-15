//
//  MockGoodSession.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
@testable import GithubPRs

///Happy path with Data
class MockGoodSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let data = MockJsonLoader().loadGoodJSON(request: request)
        let response = MockResponseLoader().loadGoodResponse(request: request)
        completionHandler(data, response, nil)
        return MockDataTask()
    }
}

class MockImageSession: URLSessionProtocol {
    var count: Int = 0
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        count += 1
        let data = MockJsonLoader().loadImage()
        let response = MockResponseLoader().loadGoodResponse(request: request)
        completionHandler(data, response, nil)
        return MockDataTask()
    }
}

