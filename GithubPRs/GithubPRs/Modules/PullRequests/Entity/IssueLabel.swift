//
//  IssueLabel.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

struct IssueLabel: Codable {
    var color: String
    var defaultField: Bool?
    var descriptionField: String?
    var id: Int
    var name: String
    var nodeId: String
    var url: String
    
    func toDomain() -> TagViewModel {
        return TagViewModel(title: name, description: descriptionField ?? "", color: UIColor(hex: color) ?? .black)
    }
}
   
