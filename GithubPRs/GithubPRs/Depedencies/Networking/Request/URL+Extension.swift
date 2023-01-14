//
//  URL+Extension.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

extension URL {
    func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }
    
    init(_ host: String, _ request: Request) {
        var queryItems: [URLQueryItem] = []
         
        for queryParam in request.queryParams
        {
            let url_query_item = URLQueryItem(name: queryParam.key, value: queryParam.value)
            queryItems.append(url_query_item)
        }
        
        let url = URL(string: host)!
            .appendingPathComponent(request.path)
            .url(with: queryItems)
        
        self.init(string: url.absoluteString)!
    }
}
