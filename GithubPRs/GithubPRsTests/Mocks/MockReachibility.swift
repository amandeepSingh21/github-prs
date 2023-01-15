//
//  MockReachibility.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import Foundation
@testable import GithubPRs

class MockReachibility: ReachabilityProtocol {
    private var isConnected = false
    
    init(isConnectedToNetwork: Bool) {
        self.isConnected = isConnectedToNetwork
    }
    
    func isConnectedToNetwork() -> Bool {
        return isConnected
    }
    
    func startMonitoring() {}
    func stopMonitoring() {}
}
