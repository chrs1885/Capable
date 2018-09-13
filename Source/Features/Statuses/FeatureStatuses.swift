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
    var features: [CapableFeature]

    init(withFeatures features: [CapableFeature]) {
        self.features = features
    }

    var statusMap: [String: String] {
        var statusMap = [String: String]()
        let statusesProvider = FeatureStatusesProvider()

        for feature in self.features {
            #if os(iOS)
            if feature == .largerText {
                statusMap[feature.rawValue] = statusesProvider.largerTextCatagory.stringValue
                continue
            }
            #elseif os(watchOS)
            if feature == .largerText {
                statusMap[feature.rawValue] = statusesProvider.largerTextCatagory
                continue
            }
            #endif
            statusMap[feature.rawValue] = statusesProvider.isFeatureEnabled(feature: feature).statusString
        }

        return statusMap
    }
}

// MARK: - Equatable
extension FeatureStatuses: Equatable {
    static func == (lhs: FeatureStatuses, rhs: FeatureStatuses) -> Bool {
        return
            lhs.features == rhs.features
    }
}
