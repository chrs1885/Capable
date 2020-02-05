//
//  NotificationCenterProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 23.08.18.
//

import Foundation

protocol NotificationCenterProtocol {
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)
    func post(name aName: NSNotification.Name, object anObject: Any?)
    func removeObserver(_ observer: Any)
}
