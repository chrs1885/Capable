//
//  FeatureStatusesProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 12.09.18.
//

protocol FeatureStatusesProtocol: StatusesProtocol {
    func isFeatureEnabled(feature: CapableFeature) -> Bool
}
