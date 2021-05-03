//
//  FeatureProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

protocol FeatureProviderProtocol {
    var statusMap: [String: String] { get }

    func isFeatureEnabled(feature: CapableFeature) -> Bool
}

class FeatureProvider: FeatureProviderProtocol {
    var accessibilityFeatures: [AccessibilityFeatureProtocol] = []
    var accessibilityFeatureProvider: AccessibilityFeatureProviderProtocol

    init(features: [CapableFeature], accessibilityFeatureProvider: AccessibilityFeatureProviderProtocol = AccessibilityFeatureProvider()) {
        self.accessibilityFeatureProvider = accessibilityFeatureProvider
        for feature in features {
            guard let accessibilityFeature = accessibilityFeatureProvider.accessibilityFeature(featureName: feature.rawValue) else { continue }
            accessibilityFeatures.append(accessibilityFeature)
        }
    }

    func isFeatureEnabled(feature: CapableFeature) -> Bool {
        guard let accessibilityFeature = accessibilityFeatureProvider.accessibilityFeature(featureName: feature.rawValue) else { return false }

        return accessibilityFeature.isEnabled
    }

    var statusMap: [String: String] {
        var statusMap = [String: String]()

        for feature in accessibilityFeatures {
            let featureClass = type(of: feature)
            statusMap[featureClass.name] = feature.status
        }

        return statusMap
    }
}
