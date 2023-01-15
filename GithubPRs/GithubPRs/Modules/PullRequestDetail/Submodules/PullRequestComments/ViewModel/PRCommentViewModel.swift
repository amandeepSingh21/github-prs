//
//  PRCommentViewModel.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

struct PRCommentViewModel {
    let id: Int
    let body: String
    let createdAt: Date
    var htmlURL: URL
    let user: UserViewModel
    var side: String
    var diffHunk: String
    var path: String
   
    var caption: String {
        "\(relativeDateFormatter.localizedString(for: createdAt, relativeTo: Date())) by \(user.userName)"
    }
    
    var description: String {
        "in: \(path)"
    }
}
