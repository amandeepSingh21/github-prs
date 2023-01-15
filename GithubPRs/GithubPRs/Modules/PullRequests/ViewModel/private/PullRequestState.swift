//
//  PullRequestState.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

enum PullRequestState {
    case open(Date), closed(Date), merged(Date)
    
    var date: Date {
        switch self {
        case .closed(let date): return date
        case .open(let date): return date
        case .merged(let date): return date
        }
    }
    
    var description: String {
        switch self {
        case .closed(_): return "closed"
        case .open(_): return "opened"
        case .merged(_): return "merged"
        }
    }
}
