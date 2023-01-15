//
//  MockCommitsData.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
@testable import GithubPRs

struct MockCommentsData {
    static func getEmpty() -> [PRCommentViewModel] {
        return []
    }
    
    static func getNonEmpty() -> [PRCommentViewModel] {
        let viewModel = PRCommentViewModel(id: 1,
                                           body: "Could use POP",
                                           createdAt: Date(),
                                           htmlURL: URL(string: "abc")!,
                                           user: .init(userName: "aman", avatarURL: URL(string: "abc")!),
                                           side: "right",
                                           diffHunk: "Changes in line 1",
                                           path: "Change in file: config.swift")
        return [viewModel]
    }
}
