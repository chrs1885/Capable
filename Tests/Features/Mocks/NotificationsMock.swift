//
//  NotificationsMock.swift
//  Capable
//
//  Created by Christoph Wendt on 18.04.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable

class NotificationsMock: NotificationsProtocol {

    var numEnableNotificationsCalled = 0
    var numDisableNotificationsCalled = 0

    required init(statusesModule: StatusesProtocol) {
    }

    public func enableNotifications(for features: [CapableFeature]) {
        self.numEnableNotificationsCalled += 1
    }

    public func disableNotifications() {
        self.numDisableNotificationsCalled += 1
    }
}

#endif
