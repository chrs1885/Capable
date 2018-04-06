//
//  NotificationsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

import Foundation

public protocol NotificationsProtocol {
    func enableNotifications(for features: [CapableFeature])
    func disableNotifications()
}
