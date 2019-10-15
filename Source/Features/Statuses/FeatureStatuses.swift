//
//  FeatureStatuses.swift
//  Capable
//
//  Created by Wendt, Christoph on 16.08.18.
//

#if os(iOS)
    import UIKit
#endif

#if os(watchOS)
    import WatchKit
#endif

class FeatureStatuses: StatusesProtocol {
    let features: [CapableFeature]
    let featureStatusesProvider: FeatureStatusesProviderProtocol

    init(withFeatures features: [CapableFeature], featureStatusesProvider: FeatureStatusesProviderProtocol) {
        self.features = features
        self.featureStatusesProvider = featureStatusesProvider
    }

    var statusMap: [String: String] {
        var statusMap = [String: String]()

        for feature in features {
            #if os(iOS)

                if feature == .hearingDevice {
                    statusMap[feature.rawValue] = featureStatusesProvider.hearingDevicePairedEar.statusString
                    continue
                }
                if feature == .largerText {
                    statusMap[feature.rawValue] = featureStatusesProvider.largerTextCatagory.stringValue
                    continue
                }

            #elseif os(watchOS)

                if feature == .largerText {
                    statusMap[feature.rawValue] = featureStatusesProvider.largerTextCatagory
                    continue
                }

            #endif

            statusMap[feature.rawValue] = featureStatusesProvider.isFeatureEnabled(feature: feature).statusString
        }

        return statusMap
    }
}

// MARK: - Equatable

extension FeatureStatuses: Equatable {
    static func == (lhs: FeatureStatuses, rhs: FeatureStatuses) -> Bool {
        return
            lhs.features == rhs.features &&
            type(of: lhs.featureStatusesProvider) == type(of: rhs.featureStatusesProvider)
    }
}
