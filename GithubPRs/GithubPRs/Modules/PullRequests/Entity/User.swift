//
//  User.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

enum UserType: String, Codable {
    case user = "User"
    case organization = "Organization"
}

struct User: Codable {
    var avatarUrl: String
    var login: String
    
    var blog: String?
    var company: String?
    var contributions: Int?
    var createdAt: Date?
    var email: String?
    var followers: Int?
    var following: Int?
    var htmlUrl: String?
    var location: String?
    var name: String?
    var type: UserType = .user
    var updatedAt: Date?
    var starredRepositoriesCount: Int?
    var repositoriesCount: Int?
    var issuesCount: Int?
    var watchingCount: Int?
    var viewerCanFollow: Bool?
    var viewerIsFollowing: Bool?
    var isViewer: Bool?
    var pinnedRepositories: [Repository]?
    var organizations: [User]?
    var descriptionField: String?
}

   
