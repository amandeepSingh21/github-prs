//
//  Collections+Extensions.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
