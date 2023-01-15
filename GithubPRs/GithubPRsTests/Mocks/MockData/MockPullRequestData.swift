//
//  MockPullRequestData.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
@testable import GithubPRs

struct MockPullRequestData {
    static func getEmpty() -> [PullRequestViewModel] {
        return []
    }
    
    static func getNonEmpty() -> [PullRequestViewModel] {
        let viewModel = PullRequestViewModel(id: 0,
                                             title: "PR-title",
                                             body: "PR-body",
                                             state: .closed(Date()),
                                             number: "#1",
                                             user: .init(userName: "user", avatarURL: URL(string: "abc")!),
                                             reviewCommentsURL: URL(string: "abc")!,
                                             commitsURL: URL(string: "abc")!,
                                             tags: [])
        return [viewModel]
    }
}
