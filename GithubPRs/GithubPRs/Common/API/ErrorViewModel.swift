//
//  ErrorViewModel.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct ErrorViewModel: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}
