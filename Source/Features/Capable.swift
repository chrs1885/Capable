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
     Initializes the framework instance with a specified set of features. If no feature was provided, this defaults to all features available on the current platform.

     - Parameters:
        - features: An optional array containing the features of interest. This will default to all features available on the current platform.
    */
    public init(withFeatures features: [CapableFeature] = CapableFeature.allCases) {
        let featureStatusesProvider = FeatureStatusesProvider()
        let statusesModule = FeatureStatuses(withFeatures: features, featureStatusesProvider: featureStatusesProvider)
        let notificationsModule = FeatureNotifications(featureStatusesProvider: featureStatusesProvider, features: features)
        self.init(withFeatures: features, featureStatusesProvider: featureStatusesProvider, statusesModule: statusesModule, notificationModule: notificationsModule)
    }

    /**
     Initializes the framework instance with a set of `Handicap`s.

     - Parameters:
        - handicaps: An optional array containing the `Handicaps`s specified by the caller.
     */
    public init(withHandicaps handicaps: [Handicap]) {
        let featureStatusesProvider = FeatureStatusesProvider()
        let statusesModule = HandicapStatuses(withHandicaps: handicaps, featureStatusesProvider: featureStatusesProvider)
        let notificationsModule = HandicapNotifications(statusesModule: statusesModule, handicaps: handicaps, featureStatusesProvider: featureStatusesProvider)
        self.init(withHandicaps: handicaps, featureStatusesProvider: featureStatusesProvider, statusesModule: statusesModule, notificationModule: notificationsModule)
    }

    init(withFeatures features: [CapableFeature], featureStatusesProvider: FeatureStatusesProviderProtocol, statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol) {
        self.features = features
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
        self.featureStatusesProvider = featureStatusesProvider

        Logger.info("Capable started with handicaps: \(features.map({ $0.rawValue }).joined(separator: ", "))")
    }

    init(withHandicaps handicaps: [Handicap], featureStatusesProvider: FeatureStatusesProviderProtocol, statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol) {
        self.handicaps = handicaps
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
        self.featureStatusesProvider = featureStatusesProvider

        Logger.info("Capable started with handicaps: \(handicaps.map({ $0.name }).joined(separator: ", "))")
    }
}

// MARK: - Accessibility Statuses
extension Capable {

    /**
     The `statusMap` property returns a dictionary of all `CapableFeature`s or `Handicap`s , that the Capable instance has been initialized with along with their current statuses. This object is compatible with most analytic SDKs such as **Fabric Answers**, **Firebase Analytics**, **AppCenter Analytics**, or **HockeyApp**.
     While most entries can only have a status set to **enabled** or **disabled**, the `.largerText` feature offers the font scale set by the user.
     */
    public var statusMap: [String: String] {
        return self.statusesModule.statusMap
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

// MARK: - Debug Logging
extension Capable {

    /**
     The minimum log level that should be considered when logging messages. Note that the custom 'onLog' closure will only be called for messages of this log type or higher. This value defaults to `OSLogType.debug`.
     */
    public static var minLogType: OSLogType {
        get {
            return Logger.minLogType
        }
        set {
            Logger.minLogType = newValue
        }
    }

    /**
     A custom closure that should be used by the logger for all Capable instances instead of the default os_log implementation.

     - Parameters:
         - message: The message string that is about to be logged.
         - logType: The 'OSLogType' of the message.
     */
    public static  var onLog: (_ message: String, _ logType: OSLogType) -> Void {
        get {
            return Logger.onLog
        }
        set {
            Logger.onLog = newValue
        }
    }
}
