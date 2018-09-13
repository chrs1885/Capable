//
//  FeatureNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

class FeatureNotifications: Notifications {
    convenience init(featureStatusesProvider: FeatureStatusesProviderProtocol, features: [CapableFeature], notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.init(featureStatusesProvider: featureStatusesProvider, notificationCenter: notificationCenter)
        self.enableNotifications(forFeatures: features)
    }

    required init(featureStatusesProvider: FeatureStatusesProviderProtocol, notificationCenter: NotificationCenter = NotificationCenter.default) {
        super.init(featureStatusesProvider: featureStatusesProvider, notificationCenter: notificationCenter)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        let featureStatus = FeatureStatus(with: feature, statusString: statusString)
        self.notificationCenter.post(name: .CapableFeatureStatusDidChange, object: featureStatus)
    }
}
