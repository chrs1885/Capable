//
//  FeatureNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

import Foundation

class FeatureNotifications: Notifications {
    convenience init(featureStatusesProvider: FeatureStatusesProviderProtocol, features: [CapableFeature], targetNotificationCenter: NotificationCenter = NotificationCenter.default, systemNotificationCenter: NotificationCenter = Notifications.systemNotificationCenter) {
        self.init(featureStatusesProvider: featureStatusesProvider, targetNotificationCenter: targetNotificationCenter, systemNotificationCenter: systemNotificationCenter)
        self.enableNotifications(forFeatures: features)
    }

    required init(featureStatusesProvider: FeatureStatusesProviderProtocol, targetNotificationCenter: NotificationCenter = NotificationCenter.default, systemNotificationCenter: NotificationCenter = Notifications.systemNotificationCenter) {
        super.init(featureStatusesProvider: featureStatusesProvider, targetNotificationCenter: targetNotificationCenter, systemNotificationCenter: systemNotificationCenter)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        let featureStatus = FeatureStatus(feature: feature, statusString: statusString)
        self.targetNotificationCenter.post(name: .CapableFeatureStatusDidChange, object: featureStatus)
    }
}
