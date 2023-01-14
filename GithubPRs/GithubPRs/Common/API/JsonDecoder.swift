//
//  JsonDecoder.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

