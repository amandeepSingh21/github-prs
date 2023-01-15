//
//  Reachiblity.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import Network

protocol ReachabilityProtocol: AnyObject {
    func isConnectedToNetwork() -> Bool
    func startMonitoring()
    func stopMonitoring()
}


final class Reachability: ReachabilityProtocol {
    static let shared = Reachability()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let monitorForWifi = NWPathMonitor(requiredInterfaceType: .wifi)
    private let monitorForCellular = NWPathMonitor(requiredInterfaceType: .cellular)
    private var wifiStatus: NWPath.Status = .requiresConnection
    private var cellularStatus: NWPath.Status = .requiresConnection
    private var isReachableOnCellular: Bool { cellularStatus == .satisfied }
    private var isReachable: Bool { wifiStatus == .satisfied || isReachableOnCellular }

    func startMonitoring() {
        monitorForWifi.pathUpdateHandler = { [weak self] path in
            self?.wifiStatus = path.status

            
            if path.status == .satisfied {
                printLog("Wifi is connected!")
                // post connected notification
            } else {
                printLog("No wifi connection.")
                // post disconnected notification
            }
        }
        monitorForCellular.pathUpdateHandler = { [weak self] path in
            self?.cellularStatus = path.status

            if path.status == .satisfied {
                printLog("Cellular connection is connected!")
                // post connected notification
            } else {
               printLog("No cellular connection.")
                // post disconnected notification
            }
        }

      
        monitorForCellular.start(queue: queue)
        monitorForWifi.start(queue: queue)
    }

    func stopMonitoring() {
        monitorForWifi.cancel()
        monitorForCellular.cancel()
    }
    
    func isConnectedToNetwork() -> Bool {
        return isReachable
    }
}
