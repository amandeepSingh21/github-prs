//
//  PullRequestViewModel.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct PullRequestViewModel {
    let id: Int
    let title: String
    let body: String
    let state: PullRequestState
    let number: String
    let user: UserViewModel
    let reviewCommentsURL: URL
    let commitsURL: URL
    let tags: [TagViewModel]
    
    var caption: String {
        "\(number) \(state.description) \(relativeDateFormatter.localizedString(for: state.date, relativeTo: Date())) by \(user.userName)"
    }
}
