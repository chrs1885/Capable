//
//  FeatureStatusesProviderProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

protocol FeatureProviderProtocol {
    var statusMap: [String: String] { get }

    func isFeatureEnabled(feature: CapableFeature) -> Bool
}
