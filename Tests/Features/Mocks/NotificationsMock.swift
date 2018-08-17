//
//  NotificationsMock.swift
//  Capable
//
//  Created by Christoph Wendt on 18.04.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable

class NotificationsMock: NotificationsProtocol {
    required init(statusesModule: StatusesProtocol) {
    }

    func postNotification(withFeature feature: CapableFeature, statusString: String) {
    }
}

#endif
