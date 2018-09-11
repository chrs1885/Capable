//
//  Capable.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

/// This class defines the main interface of the Capable framework.
public struct Capable {
    private var statusesModule: StatusesProtocol
    private var notificationsModule: NotificationsProtocol
    private(set) var features: [CapableFeature]?
    private(set) var handicaps: [Handicap]?

    /**
     The `statusMap` property returns a dictionary of all `CapableFeature`s or `Handicap`s , that the Capable instance has been initialized with along with their current statuses. This object is compatible with most analytic SDKs such as **Fabric Answers**, **Firebase Analytics**, **AppCenter Analytics**, or **HockeyApp**.
     While most entries can only have a status set to **enabled** or **disabled**, the `.largerText` feature offers the font scale set by the user.
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
        let statusesModule = FeatureStatuses(withFeatures: features)
        let notificationsModule = FeatureNotifications(statusesModule: statusesModule, features: features)
        self.init(with: statusesModule, notificationModule: notificationsModule, features: features)
    }

    /**
     Initializes the framework instance with a set of `Handicap`s.

     - Parameters:
     - handicaps: An optional array containing the `Handicaps`s specified by the caller.
     */
    public init(withHandicaps handicaps: [Handicap]) {
        let statusesModule = HandicapStatuses(withHandicaps: handicaps)
        let notificationsModule = HandicapNotifications(statusesModule: statusesModule, handicaps: handicaps)
        self.init(with: statusesModule, notificationModule: notificationsModule, handicaps: handicaps)
    }

    init(with statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol, features: [CapableFeature] = CapableFeature.allValues()) {
        self.features = features
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
    }

    init(with statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol, handicaps: [Handicap]) {
        self.handicaps = handicaps
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
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

    /**
     Provides information regarding the current status of a provided `Handicap`.

     - Parameters:
     - handicapName: The name of the requested of `Handicap`.

     - Returns: `true` if the given feature has been enabled, otherwise `false`. Note that the status depends on the `Handicap`'s `enabledIf` value (see `HandicapEnabledMode`).
     */
    public func isHandicapEnabled(handicapName: String) -> Bool {
        return self.statusesModule.isHandicapEnabled(handicapName: handicapName)
    }
}
