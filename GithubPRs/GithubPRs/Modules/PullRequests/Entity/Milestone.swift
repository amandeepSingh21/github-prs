//
//  Milestone.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct Milestone: Codable {
    var closedAt: Date?
    var closedIssues: Int?
    var createdAt: Date?
    var creator: User?
    var descriptionField: String?
    var dueOn: Date?
    var htmlUrl: String?
    var id: Int?
    var labelsUrl: String?
    var nodeId: String?
    var number: Int?
    var openIssues: Int?
    var state: State = .open
    var title: String?
    var updatedAt: Date?
    var url: String?
}
