//
//  HandicapNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

import Foundation

class HandicapNotifications: Notifications {
    var handicaps: [Handicap] = []

    convenience init(statusesModule: StatusesProtocol, handicaps: [Handicap]) {
        self.init(statusesModule: statusesModule)
        self.handicaps = handicaps
        self.enableNotifications(forHandicaps: handicaps)
    }

    required init(statusesModule: StatusesProtocol) {
        super.init(statusesModule: statusesModule)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        for handicap in self.handicaps {
            if handicap.features.contains(feature) {
                let statusString = self.statusesModule.isHandicapEnabled(handicapName: handicap.name).statusString
                let featureStatus = HandicapStatus(with: handicap, statusString: statusString)
                NotificationCenter.default.post(name: .CapableHandicapStatusDidChange, object: featureStatus)
            }
        }
    }
}

// MARK: Register Observers
extension Notifications {
    func enableNotifications(forHandicaps handicaps: [Handicap]) {
        var observedFeatures = [CapableFeature]()

        for handicap in handicaps {
            for feature in handicap.features {
                if observedFeatures.contains(feature) {
                    observedFeatures.append(feature)
                }
            }
        }

        enableNotifications(forFeatures: observedFeatures)
    }
}
