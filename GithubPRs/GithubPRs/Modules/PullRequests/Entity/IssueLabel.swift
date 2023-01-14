//
//  IssueLabel.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

struct IssueLabel: Codable {
    var color: String
    var defaultField: Bool
    var descriptionField: String
    var id: Int
    var name: String
    var nodeId: String
    var url: String
}
   
