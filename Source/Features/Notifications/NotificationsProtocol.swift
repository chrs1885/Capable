//
//  NotificationsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

protocol NotificationsProtocol {
    init(statusesModule: StatusesProtocol)
    init(statusesModule: StatusesProtocol, handicaps: [Handicap])

    func enableNotifications(forFeatures features: [CapableFeature])
    func enableNotifications(forHandicaps handicaps: [Handicap])
}
