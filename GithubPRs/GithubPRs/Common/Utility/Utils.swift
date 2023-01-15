//
//  Utils.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

func printLog(_ object: Any..., tag: String = "") {
    #if DEBUG
    debugPrint("\(String(describing: object))")
    #endif
}

let relativeDateFormatter = RelativeDateTimeFormatter()
