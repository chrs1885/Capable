//
//  NotificationsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

protocol NotificationsProtocol {
    init(statusesModule: StatusesProtocol)

    func enableNotifications(for features: [CapableFeature])
}
