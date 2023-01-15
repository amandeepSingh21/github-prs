//
//  MockPullRequestViewModel.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
@testable import GithubPRs

extension PullRequestViewModel {
    static func buildMock() -> PullRequestViewModel {
        let vm = PullRequestViewModel(id: 1,
                                      title: "",
                                      body: "",
                                      state: .closed(Date()),
                                      number: "",
                                      user: .init(userName: "abc", avatarURL: URL(string: "abc")!),
                                      reviewCommentsURL: URL(string: "https://api.github.com/repos/apple/swift/pulls/63019/comments")!,
                                      commitsURL: URL(string: "https://api.github.com/repos/apple/swift/pulls/63021/commits")!,
                                      tags: [])
        return vm
        
    }
    
}
