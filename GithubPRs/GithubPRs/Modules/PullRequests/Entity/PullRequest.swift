//
//  PullRequestResponse.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct PullRequest: Codable {
    var labels: [IssueLabel]?
    var htmlUrl: String?
    var id: Int
    var commits: Int?
    var commitsUrl: String?
    var comments: Int?
    var commentsUrl: String?
    var closedAt: Date?
    var body: String?
    var createdAt: Date?
    var mergedAt: Date?
    var mergedBy: User?
    var merged: Bool?
    var mergeable: Bool?
    var mergeableState: String?
    var state: State = .open
    var title: String?
    var updatedAt: Date
    var url: String?
    var user: User?
    var reviewComments: Int?
    var reviewCommentsUrl: String?
    var rebaseable: Bool?
    var number: Int
    
    var activeLockReason: String?
    var additions: Int?
    var assignee: User?
    var assignees: [User]?
    var authorAssociation: String?
    //var base: Base?
    var changedFiles: Int?
    var deletions: Int?
    var diffUrl: String?
    //var head: Base?
    var issueUrl: String?
    var locked: Bool?
    var maintainerCanModify: Bool?
    var mergeCommitSha: String?
    var milestone: Milestone?
    var nodeId: String?
    var patchUrl: String?
    var requestedReviewers: [User]?
    //var requestedTeams: [RequestedTeam]?
    var reviewCommentUrl: String?
    var statusesUrl: String?
}

enum State: String, Codable {
    case open
    case closed
    case all
}
