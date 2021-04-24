//
//  FeatureStatusesProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

class FeatureProvider: FeatureProviderProtocol {
    private var accessibilityFeatures: [AccessibilityFeatureProtocol] = []

    init(features: [CapableFeature]) {
        for feature in features {
            guard let accessibilityFeature = feature.accessibilityFeature else { continue }
            accessibilityFeatures.append(accessibilityFeature)
        }
    }

    func isFeatureEnabled(feature: CapableFeature) -> Bool {
        guard let accessibilityFeature = feature.accessibilityFeature else { return false }

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
