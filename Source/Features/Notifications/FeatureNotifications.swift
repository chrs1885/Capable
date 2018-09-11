//
//  FeatureNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

class FeatureNotifications: Notifications {
    convenience init(statusesModule: StatusesProtocol, features: [CapableFeature], notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.init(statusesModule: statusesModule, notificationCenter: notificationCenter)
        self.enableNotifications(forFeatures: features)
    }

    required init(statusesModule: StatusesProtocol, notificationCenter: NotificationCenter = NotificationCenter.default) {
        super.init(statusesModule: statusesModule, notificationCenter: notificationCenter)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        let featureStatus = FeatureStatus(with: feature, statusString: statusString)
        self.notificationCenter.post(name: .CapableFeatureStatusDidChange, object: featureStatus)
    }
}
