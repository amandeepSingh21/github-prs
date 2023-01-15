//
//  MockErrorLoader.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation

class MockErrorLoader {
    func getError(request: URLRequest) -> Error? {
        let error = NSError(domain: "Something went wrong", code: 100, userInfo: nil)
        return error
    }

}
