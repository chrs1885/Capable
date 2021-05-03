//
//  FeatureProviderMock.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 16.08.18.
//

@testable import Capable

class FeatureProviderMock: FeatureProviderProtocol {
    var didCallIsFeatureEnabled = false
    var requestedFeature: CapableFeature?
    
    var statusMap: [String: String] = [:]

    init() {}
    
    func isFeatureEnabled(feature: CapableFeature) -> Bool {
        didCallIsFeatureEnabled = true
        requestedFeature = feature
        
        return true
    }
}

