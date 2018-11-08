//
//  HandicapNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

import Foundation

class HandicapNotifications: Notifications {
    var handicaps: [Handicap] = []
    var statusesModule: HandicapStatusesProtocol?
    var lastValues: [String: String] = [:]

    convenience init(statusesModule: HandicapStatusesProtocol, handicaps: [Handicap], featureStatusesProvider: FeatureStatusesProviderProtocol, targetNotificationCenter: NotificationCenter = NotificationCenter.default, systemNotificationCenter: NotificationCenter = Notifications.systemNotificationCenter) {
        self.init(featureStatusesProvider: featureStatusesProvider, targetNotificationCenter: targetNotificationCenter, systemNotificationCenter: systemNotificationCenter)
        self.statusesModule = statusesModule
        self.handicaps = handicaps
        self.lastValues = Dictionary(uniqueKeysWithValues: self.handicaps.map { ($0.name, statusesModule.isHandicapEnabled(handicapName: $0.name).statusString) })
        self.enableNotifications(forHandicaps: handicaps)
    }

    required init(featureStatusesProvider: FeatureStatusesProviderProtocol, targetNotificationCenter: NotificationCenter = NotificationCenter.default, systemNotificationCenter: NotificationCenter = Notifications.systemNotificationCenter) {
        super.init(featureStatusesProvider: featureStatusesProvider, targetNotificationCenter: targetNotificationCenter, systemNotificationCenter: systemNotificationCenter)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        for handicap in self.handicaps {
            if handicap.features.contains(feature), self.hasStatusChanged(handicap: handicap) {
                self.lastValues[handicap.name] = statusString
                let handicapStatus = HandicapStatus(handicap: handicap, statusString: statusString)
                self.targetNotificationCenter.post(name: .CapableHandicapStatusDidChange, object: handicapStatus)

                Logger.info("Posted notification for handicap \(handicap.name) set to \(statusString)")
            }
        }
    }

    func hasStatusChanged(handicap: Handicap) -> Bool {
        guard let handicapStatuses = self.statusesModule as? HandicapStatuses else {
            fatalError("Capable.HandicapStatuses.hasStatusChanged: The instance hasnot been initialized with a HandicapStatuses instance.")
        }
        let currentStatus = handicapStatuses.isHandicapEnabled(handicapName: handicap.name).statusString
        let lastStatus = self.lastValues[handicap.name]

        return currentStatus != lastStatus
    }
}

// MARK: - Register Observers
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
