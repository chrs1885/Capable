//
//  NotificationsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 12.09.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class NotificationsTests: QuickSpec {
    override func spec() {
        describe("The Notifications class") {
            var notificationCenterMock: NotificationCenterMock?

            beforeEach {
                notificationCenterMock = NotificationCenterMock()
            }

            afterEach {
                notificationCenterMock = nil
            }

            context("after initialization") {
                var sut: Notifications?
                var testStatuses: FeatureStatusesMock?

                beforeEach {
                    testStatuses = FeatureStatusesMock(withFeatures: [])
                    sut = Notifications(statusesModule: testStatuses!, notificationCenter: notificationCenterMock!)
                }

                it("creates a Notifications intsance") {
                    expect(sut!).to(beAnInstanceOf(Notifications.self))
                }

                // swiftlint:disable force_cast
                it("sets properties correctly") {
                    expect((sut!.statusesModule as! FeatureStatusesMock)).to(equal(testStatuses!))
                    expect((sut!.notificationCenter)).to(equal(notificationCenterMock!))
                }
                // swiftlint:enable force_cast

                context("when calling postNotification") {
                    it("throws an error") {
                        expect(sut!.postNotification(withFeature: .assistiveTouch, statusString: "enabled")).to(throwAssertion())
                    }
                }
            }
        }
    }
}

#endif
