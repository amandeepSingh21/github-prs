//
//  Request.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

enum Method: String {
    case get = "GET"
}

struct Request {
    var method: Method
    var path: String
    var queryParams: [String: String]
    
    init(method: Method = .get, path: String, queryParams: [String: String]) {
        self.queryParams = queryParams
        self.method = method
        self.path = path
    }
    
}
