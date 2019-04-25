//
//  ReachabilityManager.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager: NSObject {
    var reachability: Reachability!
    
    //singleton instance
    static let sharedInstance: ReachabilityManager = { return ReachabilityManager() }()
    
    override init() {
        super.init()
        
        // Initialise reachability
        reachability = Reachability()!
        
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (ReachabilityManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completion: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection != .none {
            completion(ReachabilityManager.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completion: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection == .none {
            completion(ReachabilityManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completion: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection == .cellular {
            completion(ReachabilityManager.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completion: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection == .wifi {
            completion(ReachabilityManager.sharedInstance)
        }
    }
}
