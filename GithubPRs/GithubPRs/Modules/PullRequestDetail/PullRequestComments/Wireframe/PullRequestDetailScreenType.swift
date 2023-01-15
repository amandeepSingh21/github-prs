//
//  PullRequestDetailScreenType.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

enum PullRequestDetailScreenType: CaseIterable, ScreenType {
    case comments
    case commits
    
    var displayValue: String {
        switch self {
        case .comments: return "Comments"
        case .commits: return "Commits"
        }
    }
}
