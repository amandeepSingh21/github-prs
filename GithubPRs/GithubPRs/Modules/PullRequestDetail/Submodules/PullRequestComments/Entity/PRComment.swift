//
//  PRComment.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

struct PRComment: Codable {
    var id: Int
    var nodeId: String
    var authorAssociation: String
    var body: String
    var createdAt: Date
    var updatedAt: Date
    var htmlUrl: URL
    var url: URL
    var user: User
    var side: String
    var diffHunk: String
    var path: String
    
    func toDomain() -> PRCommentViewModel {
        let vm = PRCommentViewModel(id: id,
                                    body: body,
                                    createdAt: createdAt,
                                    htmlURL: htmlUrl,
                                    user: user.toDomain(),
                                    side: side,
                                    diffHunk: diffHunk,
                                    path: path)
        return vm
    }
    
    static func api(pr: PullRequestViewModel, page: PageNumber) -> Request? {
        if let path = pr.reviewCommentsURL.absoluteString.components(separatedBy: NetworkingConstants.host).last {
           return Request(path: path, queryParams: ["page": page.page, "per_page": page.perPage])
        }
        return nil
    }
}
