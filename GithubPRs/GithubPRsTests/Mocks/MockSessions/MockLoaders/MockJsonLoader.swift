//
//  MockResponseLoader.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation

class MockJsonLoader {
    
    func loadGoodJSON(request: URLRequest) -> Data {
        guard let paths =  request.url?.pathComponents else { return Data() }
        if paths.contains("comments") {
            let path = Bundle.init(for: MockJsonLoader.self).path(forResource: "comments", ofType: "json")
            let json = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            return json ?? Data()
        } else if paths.contains("commits") {
            let path = Bundle.init(for: MockJsonLoader.self).path(forResource: "commits", ofType: "json")
            let json = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            return json ?? Data()
        } else {
            let path = Bundle.init(for: MockJsonLoader.self).path(forResource: "pulls", ofType: "json")
            let json = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            return json ?? Data()
        }
    }
    
    func loadBadJSON(request: URLRequest) -> Data {
        guard let paths =  request.url?.pathComponents else { return Data() }
        let path = Bundle.init(for: MockJsonLoader.self).path(forResource: "error", ofType: "json")
        let json = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        return json ?? Data()
    }
    
    func loadImage() -> Data {
        let path = Bundle.init(for: MockJsonLoader.self).path(forResource: "github-logo", ofType: "png")
        let json = try? Data(contentsOf: URL(fileURLWithPath: path!))
        return json ?? Data()
        
    }
}
