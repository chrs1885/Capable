//
//  FeatureStatusProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

protocol FeatureStatusProviderProtocol {
    var statusMap: [String: String] { get }

    func isFeatureEnabled(feature: CapableFeature) -> Bool
}

class FeatureStatusProvider: FeatureStatusProviderProtocol {
    var features: [FeatureProtocol] = []
    var featureProvider: FeatureProviderProtocol

    init(features: [CapableFeature], featureProvider: FeatureProviderProtocol = FeatureProvider()) {
        self.featureProvider = featureProvider
        for feature in features {
            guard let accessibilityFeature = featureProvider.feature(featureName: feature.rawValue) else { continue }
            self.features.append(accessibilityFeature)
        }
    }

    func isFeatureEnabled(feature: CapableFeature) -> Bool {
        guard let accessibilityFeature = featureProvider.feature(featureName: feature.rawValue) else { return false }

        return accessibilityFeature.isEnabled
    }

    var statusMap: [String: String] {
        var statusMap = [String: String]()

        for feature in features {
            let featureClass = type(of: feature)
            statusMap[featureClass.name] = feature.status
        }

        return statusMap
    }
}
