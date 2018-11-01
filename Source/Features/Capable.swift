//
//  Capable.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

import os.log

/// This class defines the main interface of the Capable framework.
public struct Capable {
    var statusesModule: StatusesProtocol
    var notificationsModule: NotificationsProtocol
    var featureStatusesProvider: FeatureStatusesProviderProtocol
    var features: [CapableFeature]?
    var handicaps: [Handicap]?

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
    public init(withFeatures features: [CapableFeature] = CapableFeature.allCases, onLog: ((String, OSLogType) -> Void)? = nil) {
        let featureStatusesProvider = FeatureStatusesProvider()
        let statusesModule = FeatureStatuses(withFeatures: features, featureStatusesProvider: featureStatusesProvider)
        let notificationsModule = FeatureNotifications(featureStatusesProvider: featureStatusesProvider, features: features)
        self.init(withFeatures: features, featureStatusesProvider: featureStatusesProvider, statusesModule: statusesModule, notificationModule: notificationsModule, onLog: onLog)
    }

    /**
     Initializes the framework instance with a set of `Handicap`s.

     - Parameters:
     - handicaps: An optional array containing the `Handicaps`s specified by the caller.
     */
    public init(withHandicaps handicaps: [Handicap], onLog: ((String, OSLogType) -> Void)? = nil) {
        let featureStatusesProvider = FeatureStatusesProvider()
        let statusesModule = HandicapStatuses(withHandicaps: handicaps, featureStatusesProvider: featureStatusesProvider)
        let notificationsModule = HandicapNotifications(statusesModule: statusesModule, handicaps: handicaps, featureStatusesProvider: featureStatusesProvider)
        self.init(withHandicaps: handicaps, featureStatusesProvider: featureStatusesProvider, statusesModule: statusesModule, notificationModule: notificationsModule, onLog: onLog)
    }

    init(withFeatures features: [CapableFeature], featureStatusesProvider: FeatureStatusesProviderProtocol, statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol, onLog: ((String, OSLogType) -> Void)? = nil) {
        self.features = features
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
        self.featureStatusesProvider = featureStatusesProvider

        Logger.onLog = onLog ?? Logger.defaultOnLog
        Logger.info("Capable started with handicaps: \(self.features.map({ $0.rawValue }).joined(separator: ", "))")
    }

    init(withHandicaps handicaps: [Handicap], featureStatusesProvider: FeatureStatusesProviderProtocol, statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol, onLog: ((String, OSLogType) -> Void)? = nil) {
        self.handicaps = handicaps
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
        self.featureStatusesProvider = featureStatusesProvider

        Logger.onLog = onLog ?? Logger.defaultOnLog
        Logger.info("Capable started with handicaps: \(self.handicaps.map({ $0.name }).joined(separator: ", "))")
    }

    /**
     Provides information regarding the current status of a provided feature.

     - Parameters:
        - feature: The feature of interest.

     - Returns: `true` if the given feature has been enabled, otherwise `false`.
     */
    public func isFeatureEnabled(feature: CapableFeature) -> Bool {
        return self.featureStatusesProvider.isFeatureEnabled(feature: feature)
    }

    /**
     Provides information regarding the current status of a provided `Handicap`.

     - Parameters:
     - handicapName: The name of the requested of `Handicap`.

     - Returns: `true` if the given feature has been enabled, otherwise `false`. Note that the status depends on the `Handicap`'s `enabledIf` value (see `HandicapEnabledMode`).
     */
    public func isHandicapEnabled(handicapName: String) -> Bool {
        guard let handicapStatuses = self.statusesModule as? HandicapStatusesProtocol else { return false }
        return handicapStatuses.isHandicapEnabled(handicapName: handicapName)
    }
}
