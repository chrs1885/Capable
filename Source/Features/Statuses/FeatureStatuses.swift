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

class FeatureStatuses: Statuses {
    var features: [CapableFeature]

    init(withFeatures features: [CapableFeature]) {
        self.features = features
    }

    override var statusMap: [String: String] {
        var statusMap = [String: String]()

        for feature in self.features {
            #if os(iOS)
            if feature == .largerText {
                statusMap[feature.rawValue] = self.largerTextCatagory.stringValue
                continue
            }
            #elseif os(watchOS)
            if feature == .largerText {
                statusMap[feature.rawValue] = self.largerTextCatagory
                continue
            }
            #endif
            statusMap[feature.rawValue] = self.isFeatureEnabled(feature: feature).statusString
        }

        return statusMap
    }
}

// MARK: - Equatable
extension FeatureStatuses: Equatable {
    public static func == (lhs: FeatureStatuses, rhs: FeatureStatuses) -> Bool {
        return
            lhs.features == rhs.features
    }
}
