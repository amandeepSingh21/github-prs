//
//  GHError.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//
import Foundation
///Documentation: https://docs.github.com/en/rest/overview/resources-in-the-rest-api?apiVersion=2022-11-28
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
