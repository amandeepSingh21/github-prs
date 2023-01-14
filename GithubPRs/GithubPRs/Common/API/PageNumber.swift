//
//  PageNumber.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation


struct PageNumber: ExpressibleByIntegerLiteral {
    let page: String
    var perPage: String
    
    init(page: Int, perPage: Int = 10) {
        self.page = String(page)
        self.perPage = String(perPage)
    }
    
    init(integerLiteral value: Int) {
        self.page = String(value)
        self.perPage = String(10)
    }
}
