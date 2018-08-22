//
//  HandicapNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

import Foundation

class HandicapNotifications: Notifications {
    var handicaps: [Handicap] = []
    var lastValues: [String: String] = [:]

    convenience init(statusesModule: StatusesProtocol, handicaps: [Handicap]) {
        self.init(statusesModule: statusesModule)
        self.handicaps = handicaps
        self.lastValues = Dictionary(uniqueKeysWithValues: self.handicaps.map { ($0.name, self.statusesModule.isHandicapEnabled(handicapName: $0.name).statusString) })
        self.enableNotifications(forHandicaps: handicaps)
    }

    required init(statusesModule: StatusesProtocol) {
        super.init(statusesModule: statusesModule)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        for handicap in self.handicaps {
            if handicap.features.contains(feature), self.hasStatusChanged(handicap: handicap) {
                self.lastValues[handicap.name] = statusString
                let handicapStatus = HandicapStatus(with: handicap, statusString: statusString)
                NotificationCenter.default.post(name: .CapableHandicapStatusDidChange, object: handicapStatus)
            }
        }
    }

    func hasStatusChanged(handicap: Handicap) -> Bool {
        let currentStatus = self.statusesModule.isHandicapEnabled(handicapName: handicap.name).statusString
        let lastStatus = self.lastValues[handicap.name]

        return currentStatus != lastStatus
    }
}

// MARK: Register Observers
extension Notifications {
    func enableNotifications(forHandicaps handicaps: [Handicap]) {
        var observedFeatures = [CapableFeature]()

        for handicap in handicaps {
            for feature in handicap.features {
                if !observedFeatures.contains(feature) {
                    observedFeatures.append(feature)
                }
            }
        }

        enableNotifications(forFeatures: observedFeatures)
    }
}
