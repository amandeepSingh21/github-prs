//
//  PullRequestViewState.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

enum PullRequestViewState {
    case notLoaded
    case loading(String)
    case noResultsFound
    case loaded
    case error(ErrorViewModel)
    
    var message: String {
        switch self {
        case .noResultsFound:
            return NSLocalizedString("No results found :(", comment: "")
        case .notLoaded:
            return NSLocalizedString( "Start searching :(", comment: "")
        case .loading(_):
            return NSLocalizedString("Loading results....", comment: "")
        default:
            return ""
        }
    }
    
}

extension PullRequestViewState: Equatable {
    static func == (lhs: PullRequestViewState, rhs: PullRequestViewState) -> Bool {
        switch (lhs, rhs) {
        case (.notLoaded, .notLoaded): return true
        case (.loaded, .loaded): return true
        case (.loading(_), .loading(_)): return true
        case (.error(_), .error(_)): return true
        case (.noResultsFound, .noResultsFound): return true
        default: return false
        }
    }
    
}
