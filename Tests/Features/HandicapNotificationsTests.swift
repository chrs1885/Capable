//
//  HandicapNotificationsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 25.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class HandicapNotificationsTests: QuickSpec {
    override func spec() {
        describe("The HandicapNotifications class") {
            let handicapDidChangeNotification = Notification.Name.CapableHandicapStatusDidChange
            var notificationCenterMock: NotificationCenterMock?

            beforeEach {
                notificationCenterMock = NotificationCenterMock()
            }

            afterEach {
                notificationCenterMock = nil
            }

            context("after initialization") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatusesMock?
                var testHandicaps: [Handicap]?

                beforeEach {
                    let handicap = Handicap(with: [], name: "test", enabledIf: .allFeaturesEnabled)
                    testHandicaps = [handicap]
                    testStatuses = HandicapStatusesMock(withHandicaps: [])
                    sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: testHandicaps!, notificationCenter: notificationCenterMock!)
                }

                it("creates a HandicapNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(HandicapNotifications.self))
                }

                // swiftlint:disable force_cast
                it("sets properties correctly") {
                    expect((sut!.statusesModule as! HandicapStatusesMock)).to(equal(testStatuses!))
                    expect((sut!.notificationCenter)).to(equal(notificationCenterMock!))
                }
                // swiftlint:enable force_cast
            }

            context("after initialization with required initializer") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatusesMock?

                beforeEach {
                    testStatuses = HandicapStatusesMock(withHandicaps: [])
                    sut = HandicapNotifications(statusesModule: testStatuses!, notificationCenter: notificationCenterMock!)
                }

                it("creates a HandicapNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(HandicapNotifications.self))
                }

                // swiftlint:disable force_cast
                it("sets statuses property correctly") {
                    expect((sut!.statusesModule as! HandicapStatusesMock)).to(equal(testStatuses!))
                    expect((sut!.notificationCenter)).to(equal(notificationCenterMock!))
                }
                // swiftlint:enable force_cast
            }

            #if os(iOS) || os(tvOS)

            let placeholderNotification = NSNotification(name: .UIAccessibilitySpeakScreenStatusDidChange, object: nil)

            context("after initialization with two Handicaps containing the same feature") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatusesMock?
                var testHandicap1: Handicap?
                var testHandicap2: Handicap?
                var testFeature: CapableFeature?

                beforeEach {
                    testFeature = .voiceOver
                    testHandicap1 = Handicap(with: [testFeature!], name: "testHandicap1", enabledIf: .oneFeatureEnabled)
                    testHandicap2 = Handicap(with: [testFeature!], name: "testHandicap2", enabledIf: .oneFeatureEnabled)
                    testStatuses = HandicapStatusesMock(withHandicaps: [testHandicap1!, testHandicap2!])
                    sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [testHandicap1!, testHandicap2!], notificationCenter: notificationCenterMock!)
                }

                it("registers itself as observer for the feature notification only once") {
                    expect(notificationCenterMock?.observedNotifications.count).to(equal(1))
                    expect(notificationCenterMock?.hasRegisteredNotification(forFeature: testFeature!)).to(beTrue())
                }
            }

            context("after initialization with a Handicap containing two features") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatusesMock?
                var testHandicap: Handicap?
                var testFeature1: CapableFeature?
                var testFeature2: CapableFeature?

                beforeEach {
                    testFeature1 = .voiceOver
                    testFeature2 = .reduceMotion
                }

                context("when .enabledIf is set to .oneFeatureEnabled and both features are currently disabled") {
                    beforeEach {
                        testHandicap = Handicap(with: [testFeature1!, testFeature2!], name: "testHandicap", enabledIf: .oneFeatureEnabled)
                        testStatuses = HandicapStatusesMock(withHandicaps: [testHandicap!])
                        testStatuses?.voiceOverEnabled = false
                        testStatuses?.reduceMotionEnabled = false
                        sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [testHandicap!], notificationCenter: notificationCenterMock!)
                    }

                    afterEach {
                        testStatuses?.voiceOverEnabled = false
                        testStatuses?.reduceMotionEnabled = false
                    }

                    it("registers itself as observer for both notifications") {
                        expect(notificationCenterMock?.observedNotifications.count).to(equal(2))
                        expect(notificationCenterMock?.hasRegisteredNotification(forFeature: testFeature1!)).to(beTrue())
                        expect(notificationCenterMock?.hasRegisteredNotification(forFeature: testFeature2!)).to(beTrue())
                    }

                    context("when features get enabled one by one") {
                        it("posts a CapableHandicapStatusDidChange notification with the correct HandicapStatus only if needed") {
                            // Enable feature 1 => a notification is posted with status "enabled"
                            testStatuses?.voiceOverEnabled = true
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "enabled")

                            // Enable feature 2 => no notification is posted
                            testStatuses?.reduceMotionEnabled = true
                            sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                            expect(notificationCenterMock?.postedNotifications.count).to(equal(1))

                            // Disable feature 2 => no notification is posted
                            testStatuses?.reduceMotionEnabled = false
                            sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                            expect(notificationCenterMock?.postedNotifications.count).to(equal(1))

                            // Disable feature 2 => a notification is posted with status "disabled"
                            testStatuses?.voiceOverEnabled = false
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "disabled")
                        }
                    }
                }

                context("when .enabledIf is set to .allFeaturesEnabled and both features are currently disabled") {
                    beforeEach {
                        testHandicap = Handicap(with: [testFeature1!, testFeature2!], name: "testHandicap", enabledIf: .allFeaturesEnabled)
                        testStatuses = HandicapStatusesMock(withHandicaps: [testHandicap!])
                        testStatuses?.voiceOverEnabled = false
                        testStatuses?.reduceMotionEnabled = false
                        sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [testHandicap!], notificationCenter: notificationCenterMock!)
                    }

                    afterEach {
                        testStatuses?.voiceOverEnabled = false
                        testStatuses?.reduceMotionEnabled = false
                    }

                    context("when features get enabled one by one") {
                        it("posts a CapableHandicapStatusDidChange notification with the correct HandicapStatus only if needed") {
                            // Enable feature 1 => no notification is posted
                            testStatuses?.voiceOverEnabled = true
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            expect(notificationCenterMock?.postedNotifications.count).to(equal(0))

                            // Enable feature 2 => a notification is posted with status "enabled"
                            testStatuses?.reduceMotionEnabled = true
                            sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "enabled")

                            // Disable feature 1 => a notification is posted with status "disabled"
                            testStatuses?.voiceOverEnabled = false
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "disabled")
                        }
                    }
                }
            }

            func verifyHandicapDidChangeNotificationWasPosted(withHandicap handicap: Handicap, statusString: String) {
                expect(notificationCenterMock?.postedNotifications.count).to(equal(1))

                let notificationObject = notificationCenterMock?.postedNotifications[handicapDidChangeNotification]
                guard let handicapStatus = notificationObject as? HandicapStatus else {
                    fail("Notification does not contain a HandicapStatus object.")
                    return
                }
                expect(handicapStatus.handicap).to(equal(handicap))
                expect(handicapStatus.statusString).to(equal(statusString))
            }

            #endif

        }
    }
}

#endif
