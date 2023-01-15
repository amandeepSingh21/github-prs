//
//  MockResponseLoader.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation

class MockResponseLoader {
    
    func loadGoodResponse(request: URLRequest) -> URLResponse? {
        HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
    
    func loadBadResponse(request: URLRequest) -> URLResponse? {
        HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)
    }
    
    func loadRateLimitedResponse(request: URLRequest) -> URLResponse? {
        let headers = ["X-RateLimit-Remaining" : "0", "X-RateLimit-Reset": "1000"]
        let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: headers)
        return response
        
    }
}
