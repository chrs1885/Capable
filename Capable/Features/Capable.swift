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
    
    public var statusMap: [CapableFeature: String] {
        get {
            return self.statusesModule.statusMap
        }
    }
    public var notificationsEnabled: Bool = false {
        didSet {
            if self.notificationsEnabled != oldValue {
                self.notificationsEnabled ?
                    self.notificationsModule.enableNotifications(for: self.features) :
                    self.notificationsModule.disableNotifications()
            }
        }
    }
    
    public init() {
        self.init(with: CapableFeature.allValues())
    }
    
    public init(with features: [CapableFeature]) {
        self.features = features
        self.statusesModule = Statuses(with: self.features)
        self.notificationsModule = Notifications(statusesModule: statusesModule)
        self.notificationsModule.enableNotifications(for: self.features)
    }
    
    public func isFeatureEnable(feature: CapableFeature) -> Bool {
        return self.statusesModule.isFeatureEnable(feature: feature)
    }
}
