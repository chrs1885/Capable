//
//  NotificationCenterMock.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable

class NotificationCenterMock: NotificationCenter {
    var observedNotifications: [Notification.Name] = []
    var postedNotifications: [Notification.Name: Any?] = [:]

    override func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        if let notificationName = aName {
            self.observedNotifications.append(notificationName)
        }
        super.addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }

    override func post(name aName: NSNotification.Name, object anObject: Any?) {
        self.postedNotifications[aName] = anObject
        super.post(name: aName, object: anObject)
    }

    func hasRegisteredNotification(forFeature feature: CapableFeature) -> Bool {
        #if os(iOS)
        if feature == .largerText {
            return self.observedNotifications.contains(.UIContentSizeCategoryDidChange)
        }
        #endif

        return self.observedNotifications.contains(where: {
            $0.rawValue.range(of: feature.rawValue, options: .caseInsensitive) != nil
        })
    }

    func hasRegisteredNotification(forName name: Notification.Name) -> Bool {
        return self.observedNotifications.contains(name)
    }

    func hasPostedNotification(forFeature feature: CapableFeature) -> Bool {
        let notificationNames = Array(self.postedNotifications.keys)

        #if os(iOS)
        if feature == .largerText {
            return notificationNames.contains(.UIContentSizeCategoryDidChange)
        }
        #endif

        return notificationNames.contains(where: {
            $0.rawValue.range(of: feature.rawValue, options: .caseInsensitive) != nil
        })
    }

    func hasPostedNotification(forName name: Notification.Name) -> Bool {
        let notificationNames = Array(self.postedNotifications.keys)
        return notificationNames.contains(name)
    }
}

#endif