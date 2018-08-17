//
//  FeatureNotifications.swift
//  Capable
//
//  Created by Wendt, Christoph on 17.08.18.
//

class FeatureNotifications: Notifications {
    convenience init(statusesModule: StatusesProtocol, features: [CapableFeature]) {
        self.init(statusesModule: statusesModule)
        self.enableNotifications(forFeatures: features)
    }

    required init(statusesModule: StatusesProtocol) {
        super.init(statusesModule: statusesModule)
    }

    override func postNotification(withFeature feature: CapableFeature, statusString: String) {
        let featureStatus = FeatureStatus(with: feature, statusString: statusString)
        NotificationCenter.default.post(name: .CapableFeatureStatusDidChange, object: featureStatus)
    }
}
