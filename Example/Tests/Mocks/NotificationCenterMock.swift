//
//  NotificationCenterMock.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    #if os(iOS) || os(tvOS)
        import UIKit
    #endif

    @testable import Capable

    class NotificationCenterMock: NotificationCenter {
        var observedNotifications: [Notification.Name] = []
        var postedNotifications: [Notification.Name: Any?] = [:]

        override func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
            if let notificationName = aName {
                observedNotifications.append(notificationName)
            }
            super.addObserver(observer, selector: aSelector, name: aName, object: anObject)
        }

        override func post(name aName: NSNotification.Name, object anObject: Any?) {
            postedNotifications[aName] = anObject
            super.post(name: aName, object: anObject)
        }

        func hasRegisteredNotification(forFeature feature: CapableFeature) -> Bool {
            #if os(iOS)
                if feature == .largerText {
                    return observedNotifications.contains(UIContentSizeCategory.didChangeNotification)
                }
            #endif

            return observedNotifications.contains(where: {
                $0.rawValue.range(of: feature.rawValue, options: .caseInsensitive) != nil
            })
        }

        func hasRegisteredNotification(forName name: Notification.Name) -> Bool {
            return observedNotifications.contains(name)
        }

        func hasPostedNotification(forFeature feature: CapableFeature) -> Bool {
            let notificationNames = Array(postedNotifications.keys)

            #if os(iOS)
                if feature == .largerText {
                    return notificationNames.contains(UIContentSizeCategory.didChangeNotification)
                }
            #endif

            return notificationNames.contains(where: {
                $0.rawValue.range(of: feature.rawValue, options: .caseInsensitive) != nil
            })
        }

        func hasPostedNotification(forName name: Notification.Name) -> Bool {
            let notificationNames = Array(postedNotifications.keys)
            return notificationNames.contains(name)
        }
    }

#endif
