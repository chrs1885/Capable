//
//  Capable.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

import Foundation

/// This class defines the main interface of the Capable framework.
public struct Capable {
    private var statusesModule: StatusesProtocol
    private var notificationsModule: NotificationsProtocol
    private(set) var features: [CapableFeature]

    /**
     The `statusMap` property returns a dictionary of all features, that the Capable instance has been initialized with along with their current statuses. This object is compatible with most analytic SDKs such as **Fabric Answers**, **Firebase Analytics**, **AppCenter Analytics**, or **HockeyApp**.
     While most features can only have a status set to **enabled** or **disabled**, the `.largerText` feature offers the font scale set by the user.
     */
    public var statusMap: [String: String] {
        return self.statusesModule.statusMap
    }

    /**
     Initializes the framework instance with a specified set of features. If no feature was provided, this defaults to all features available on the current platform.

     - Parameters:
        - features: An optional array containing the features of interest. This will default to all features available on the current platform.
    */
    public init(withFeatures features: [CapableFeature] = CapableFeature.allValues()) {
        let statusesModule = Statuses(with: features)
        let notificationsModule = Notifications(statusesModule: statusesModule)
        self.init(with: statusesModule, notificationModule: notificationsModule, features: features)
    }

    init(with statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol, features: [CapableFeature] = CapableFeature.allValues()) {
        self.features = features
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
        self.notificationsModule.enableNotifications(for: self.features)
    }

    /**
     Provides information regarding the current status of a provided feature.

     - Parameters:
        - feature: The feature of interest.

     - Returns: `true` if the given feature has been enabled, otherwise `false`.
     */
    public func isFeatureEnabled(feature: CapableFeature) -> Bool {
        return self.statusesModule.isFeatureEnabled(feature: feature)
    }
}
