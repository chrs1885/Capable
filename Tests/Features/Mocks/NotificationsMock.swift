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

    required init(statusesModule: StatusesProtocol) {
    }

    required init(statusesModule: StatusesProtocol, handicaps: [Handicap]) {
    }

    public func enableNotifications(forFeatures features: [CapableFeature]) {
        self.numEnableNotificationsCalled += 1
    }

    func enableNotifications(forHandicaps handicaps: [Handicap]) {
        self.numEnableNotificationsCalled += 1
    }
}

#endif
