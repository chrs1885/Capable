//
//  NotificationsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

import Foundation

protocol NotificationsProtocol {
    init(statusesModule: StatusesProtocol)
    
    func enableNotifications(for features: [CapableFeature])
    func disableNotifications()
}
