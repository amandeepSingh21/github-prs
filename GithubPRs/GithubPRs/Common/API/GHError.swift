//
//  GHError.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//
import Foundation

struct GHError: Decodable {
    let message: String
    let errors: [GHErrorReason]?
    let documentationURL: String?
}

struct GHErrorReason: Decodable {
    let resource: String?
    let field: String?
    let code: String?
}
