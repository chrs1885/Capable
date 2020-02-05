//
//  NotificationsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 12.09.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable
    import Nimble
    import Quick

    class NotificationsTests: QuickSpec {
        override func spec() {
            describe("The Notifications class") {
                var targetNotificationCenterMock: NotificationCenterMock?
                var systemNotificationCenterMock: NotificationCenterMock?
                var featureStatusesProviderMock: FeatureStatusesProviderMock?

                beforeEach {
                    targetNotificationCenterMock = NotificationCenterMock()
                    systemNotificationCenterMock = NotificationCenterMock()
                    featureStatusesProviderMock = FeatureStatusesProviderMock()
                }

                context("after initialization") {
                    var sut: Notifications?

                    beforeEach {
                        sut = Notifications(featureStatusesProvider: featureStatusesProviderMock!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                    }

                    it("creates a Notifications intsance") {
                        expect(sut!).to(beAnInstanceOf(Notifications.self))
                    }

                    it("sets properties correctly") {
                        expect(sut!.featureStatusesProvider).to(be(featureStatusesProviderMock!))
                        expect(sut!.targetNotificationCenter).to(equal(targetNotificationCenterMock!))
                        expect(sut!.systemNotificationCenter).to(equal(systemNotificationCenterMock!))
                    }

                    #if os(iOS) || os(OSX)

                        context("when calling postNotification") {
                            it("throws an error") {
                                expect(sut!.postNotification(withFeature: .voiceOver, statusString: "enabled")).to(throwAssertion())
                            }
                        }

                    #endif
                }
            }
        }
    }

#endif
