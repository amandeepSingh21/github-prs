//
//  PullRequestResponse.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct PullRequest: Codable {
    var labels: [IssueLabel]
    var htmlUrl: String?
    var id: Int
    var commits: Int?
    var commitsUrl: URL
    var comments: Int?
    var commentsUrl: URL
    var closedAt: Date?
    var body: String?
    var createdAt: Date
    var mergedAt: Date?
    var mergedBy: User?
    var merged: Bool?
    var mergeable: Bool?
    var mergeableState: String?
    var state: State = .open
    var title: String
    var updatedAt: Date
    var url: String?
    var user: User
    var reviewComments: Int?
    var reviewCommentsUrl: URL
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
    
    func toDomain() -> PullRequestViewModel {
        let tags = labels.map { $0.toDomain() }
        return PullRequestViewModel(id: id,
                                     title: title,
                                     body: body ?? "",
                                     state: pullRequestState(),
                                     number: "#\(number)",
                                     user: user.toDomain(),
                                     reviewCommentsURL: self.reviewCommentsUrl,
                                     commitsURL: self.commitsUrl,
                                     tags: tags)
        
    }
    
    private func pullRequestState() -> PullRequestState {
        if let mergedAt = self.mergedAt {
            return .merged(mergedAt)
        }
        if let closedAt = self.closedAt {
            return .closed(closedAt)
        }
        return .open(self.createdAt)
    }
    
    static func api(organization: String, repo: String, status: String, page: PageNumber) -> Request {
        Request(path: "/repos/\(organization)/\(repo)/pulls", queryParams: ["page": page.page, "per_page": page.perPage, "state": status])
    }
}

enum State: String, Codable {
    case open
    case closed
    case all
}
