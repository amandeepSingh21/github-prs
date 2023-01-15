//
//  MockCommitsData.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
@testable import GithubPRs

struct MockCommitsData {
    static func getEmpty() -> [PRCommitViewModel] {
        return []
    }
    
    static func getNonEmpty() -> [PRCommitViewModel] {
        let viewModel = PRCommitViewModel(htmlURL: URL(string: "abc")!,
                                          message: "abc", date: Date(),
                                          name: "abc",
                                          commentCount: 1,
                                          avatarURL: URL(string: "abc")!)
        return [viewModel]
    }
}
