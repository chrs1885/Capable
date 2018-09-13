//
//  HandicapStatuses.swift
//  Capable
//
//  Created by Wendt, Christoph on 16.08.18.
//

class HandicapStatuses: HandicapStatusesProtocol {
    var handicapMap: [String: Handicap]

    init(withHandicaps handicaps: [Handicap]) {
        self.handicapMap = Dictionary(uniqueKeysWithValues: handicaps.map { ($0.name, $0) })
    }

    var statusMap: [String: String] {
        var statusMap = [String: String]()
        for handicapName in handicapMap.keys {
            statusMap[handicapName] = self.isHandicapEnabled(handicapName: handicapName).statusString
        }

        return statusMap
    }

    func isHandicapEnabled(handicapName: String) -> Bool {
        guard let handicap = self.handicapMap[handicapName] else {
            return false
        }

        let statusesProvider = FeatureStatusesProvider()

        for feature in handicap.features {
            let isFeatureEnabled = statusesProvider.isFeatureEnabled(feature: feature)
            if isFeatureEnabled, handicap.enabledIf == .oneFeatureEnabled {
                return true
            } else if !isFeatureEnabled, handicap.enabledIf == .allFeaturesEnabled {
                return false
            }
        }

        return handicap.enabledIf == .allFeaturesEnabled
    }
}

// MARK: - Equatable
extension HandicapStatuses: Equatable {
    static func == (lhs: HandicapStatuses, rhs: HandicapStatuses) -> Bool {
        return
            lhs.handicapMap == rhs.handicapMap
    }
}
