//
//  ErrorViewModel.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct ErrorViewModel: Error {
    let message: String
    let networkError: NetworkError?
    
    init(_ message: String, networkError: NetworkError? = nil) {
        self.message = message
        self.networkError = networkError
    }
}

