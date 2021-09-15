//
//  Capable.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

import os.log

/// This class defines the main interface of the Capable framework.
public struct Capable {
    var featureStatusProvider: FeatureStatusProviderProtocol
    var features: [CapableFeature]?

    /**
     Initializes the framework instance with a specified set of features. If no feature was provided, this defaults to all features available on the current platform.

     - Parameters:
        - features: An optional array containing the features of interest. This will default to all features available on the current platform.
     */
    public init(withFeatures features: [CapableFeature] = CapableFeature.allCases) {
        let featureStatusProvider = FeatureStatusProvider(features: features)
        self.init(withFeatures: features, featureStatusProvider: featureStatusProvider)
    }

    init(withFeatures features: [CapableFeature], featureStatusProvider: FeatureStatusProviderProtocol) {
        self.features = features
        self.featureStatusProvider = featureStatusProvider

        Logger.info("Capable started with features: \(features.map { $0.rawValue }.joined(separator: ", "))")
    }
}

// MARK: - Feature Statuses

public extension Capable {
    /**
     The `statusMap` property returns a dictionary of all `CapableFeature`s, that the Capable instance has been initialized with along with their current statuses. This object is compatible with most analytic SDKs such as **Fabric Answers**, **Firebase Analytics**, **AppCenter Analytics**, or **HockeyApp**.
     While most entries can only have a status set to **enabled** or **disabled**, the `.largerText` feature offers the font scale set by the user.
     */
    var statusMap: [String: String] {
        return featureStatusProvider.statusMap
    }

    /**
     Provides information regarding the current status of a provided feature.

     - Parameters:
        - feature: The feature of interest.

     - Returns: `true` if the given feature has been enabled, otherwise `false`.
     */
    func isFeatureEnabled(feature: CapableFeature) -> Bool {
        return featureStatusProvider.isFeatureEnabled(feature: feature)
    }
}

// MARK: - Debug Logging

public extension Capable {
    /**
     The minimum log level that should be considered when logging messages. Note that the custom 'onLog' closure will only be called for messages of this log type or higher. This value defaults to `OSLogType.debug`.
     */
    static var minLogType: OSLogType {
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
    static var onLog: (_ message: String, _ logType: OSLogType) -> Void {
        get {
            return Logger.onLog
        }
        set {
            Logger.onLog = newValue
        }
    }
}
