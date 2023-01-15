//
//  PullRequestScreenType.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

enum PullRequestScreenType: CaseIterable, ScreenType {
    case open
    case closed
    
    var displayValue: String {
        switch self {
        case .open: return "Open"
        case .closed: return "Closed"
        }
    }
    
    var apiValue: String {
        switch self {
        case .open: return "open"
        case .closed: return "closed"
        }
    }
}
