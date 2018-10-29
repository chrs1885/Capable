//
//  NotificationsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

protocol NotificationsProtocol {
    init(featureStatusesProvider: FeatureStatusesProviderProtocol, targetNotificationCenter: NotificationCenter, systemNotificationCenter: NotificationCenter)
    func postNotification(withFeature feature: CapableFeature, statusString: String)
}
