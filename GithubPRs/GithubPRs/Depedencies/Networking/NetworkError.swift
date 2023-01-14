//
//  NetworkError.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct NetworkError: Error {
     let urlSessionError: HTTPError ///Generic network error
     let apiError: Data? ///Domain specfic error to be parsed by the clients
     
     init(_ error: HTTPError, apiError: Data? = nil) {
         self.urlSessionError = error
         self.apiError = apiError
     }
}

struct HTTPError: Error {
    let message: String ///Fallback  generic message
    let underlyingError: NSError? ///Maps to URLSession NSError
    let statusCode: Int? ///Maps to HTTP status code
    
    init(_ message: String, underlyingError: NSError? = nil, statusCode: Int? = nil) {
        self.message = message
        self.underlyingError = underlyingError
        self.statusCode = statusCode
    }
    
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

extension URLResponse {
    var isSuccess: Bool {
        return httpStatusCode >= 200 && httpStatusCode < 300
    }
    
    var httpStatusCode: Int {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return 0
        }
        return statusCode
    }
}
