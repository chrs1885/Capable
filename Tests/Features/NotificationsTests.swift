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
            var featureStatusesProviderMock: FeatureStatusesProviderMock?

            beforeEach {
                notificationCenterMock = NotificationCenterMock()
                featureStatusesProviderMock = FeatureStatusesProviderMock()
            }

            context("after initialization") {
                var sut: Notifications?

                beforeEach {
                    sut = Notifications(featureStatusesProvider: featureStatusesProviderMock!, notificationCenter: notificationCenterMock!)
                }

                it("creates a Notifications intsance") {
                    expect(sut!).to(beAnInstanceOf(Notifications.self))
                }

                it("sets properties correctly") {
                    expect(sut!.featureStatusesProvider).to(be(featureStatusesProviderMock!))
                    expect((sut!.notificationCenter)).to(equal(notificationCenterMock!))
                }

                context("when calling postNotification") {
                    it("throws an error") {
                        expect(sut!.postNotification(withFeature: .voiceOver, statusString: "enabled")).to(throwAssertion())
                    }
                }
            }
        }
    }
}

#endif
