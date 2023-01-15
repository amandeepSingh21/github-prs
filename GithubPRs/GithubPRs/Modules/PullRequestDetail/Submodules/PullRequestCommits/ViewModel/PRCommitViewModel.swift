//
//  PRCommitViewModel.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

struct PRCommitViewModel {
    let htmlURL: URL
    let message: String
    let date: Date
    let name: String
    let commentCount: Int
    let avatarURL: URL
   
    var description: String {
        "\(relativeDateFormatter.localizedString(for: date, relativeTo: Date())) by \(name)"
    }
    
    var caption: String {
        "Total comments: \(commentCount)"
    }
}

