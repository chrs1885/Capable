//
//  Capable.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

import Foundation

public struct Capable {
    private var statusesModule: StatusesProtocol
    private var notificationsModule: NotificationsProtocol
    private(set) var features: [CapableFeature]

    public var statusMap: [String: String] {
        return self.statusesModule.statusMap
    }
    public var notificationsEnabled: Bool = false {
        didSet {
            if notificationsEnabled != oldValue {
                notificationsEnabled ?
                    self.notificationsModule.enableNotifications(for: self.features) :
                    self.notificationsModule.disableNotifications()
            }
        }
    }

    public init(with features: [CapableFeature] = CapableFeature.allValues()) {
        let statusesModule = Statuses(with: features)
        let notificationsModule = Notifications(statusesModule: statusesModule)
        self.init(with: statusesModule, notificationModule: notificationsModule, features: features)
    }

    init(with statusesModule: StatusesProtocol, notificationModule: NotificationsProtocol, features: [CapableFeature] = CapableFeature.allValues()) {
        self.features = features
        self.statusesModule = statusesModule
        self.notificationsModule = notificationModule
        defer {
            self.notificationsEnabled = true
        }
    }

    public func isFeatureEnabled(feature: CapableFeature) -> Bool {
        return self.statusesModule.isFeatureEnabled(feature: feature)
    }
}
