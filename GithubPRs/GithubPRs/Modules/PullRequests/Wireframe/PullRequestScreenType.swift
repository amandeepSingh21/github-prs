//
//  PullRequestScreenType.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

protocol ScreenType {
    var displayValue: String { get }
    var apiValue: String { get }
}

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
        case .open: return "ppen"
        case .closed: return "closed"
        }
    }
}
