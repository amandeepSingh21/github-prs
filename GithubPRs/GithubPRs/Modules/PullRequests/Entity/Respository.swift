//
//  Respository.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct Repository: Codable {
    var archived: Bool?
    var cloneUrl: String?
    var createdAt: Date?
    var defaultBranch = "master"
    var descriptionField: String?
    var fork: Bool?
    var forks: Int?
    var forksCount: Int?
    var fullname: String?
    var hasDownloads: Bool?
    var hasIssues: Bool?
    var hasPages: Bool?
    var hasProjects: Bool?
    var hasWiki: Bool?
    var homepage: String?
    var htmlUrl: String?
    var language: String?
    var languageColor: String?
    var license: License?
    var name: String?
    var networkCount: Int?
    var nodeId: String?
    var openIssues: Int?
    var openIssuesCount: Int?
    var organization: User?
    var owner: User?
    var privateField: Bool?
    var pushedAt: String?
    var size: Int?
    var sshUrl: String?
    var stargazersCount: Int?
    var subscribersCount: Int?
    var updatedAt: Date?
    var url: String?
    var watchers: Int?
    var watchersCount: Int?
    var parentFullname: String?
    var commitsCount: Int?
    var pullRequestsCount: Int?
    var branchesCount: Int?
    var releasesCount: Int?
    var contributorsCount: Int?
    var viewerHasStarred: Bool?
}
