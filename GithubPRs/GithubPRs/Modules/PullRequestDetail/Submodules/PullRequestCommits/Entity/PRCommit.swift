//
//  PRCommits.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

struct PRCommit: Decodable {
    let url: String
    let sha,nodeId: String
    let htmlUrl, commentsUrl: URL
    let commit: Commit
    let author, committer: User
    
    func toDomain() -> PRCommitViewModel {
        .init(htmlURL: htmlUrl,
              message: commit.message,
              date: commit.author.date,
              name: author.login,
              commentCount: commit.commentCount,
              avatarURL: author.avatarUrl)
    }
    
    static func api(pr: PullRequestViewModel, page: PageNumber) -> Request? {
        if let path = pr.commitsURL.absoluteString.components(separatedBy: NetworkingConstants.host).last {
           return Request(path: path, queryParams: ["page": page.page, "per_page": page.perPage])
        }
        return nil
    }
}

struct Commit: Decodable {
    let url: String
    let author, committer: CommitAuthor
    let message: String
    let commentCount: Int
   
}

struct CommitAuthor: Decodable {
    let name, email: String
    let date: Date
}
