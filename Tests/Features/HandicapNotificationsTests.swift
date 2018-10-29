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
            var targetNotificationCenterMock: NotificationCenterMock?
            var systemNotificationCenterMock: NotificationCenterMock?
            var featureStatusesProviderMock: FeatureStatusesProviderMock?

            beforeEach {
                targetNotificationCenterMock = NotificationCenterMock()
                systemNotificationCenterMock = NotificationCenterMock()
                featureStatusesProviderMock = FeatureStatusesProviderMock()
            }

            context("after initialization") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatuses?
                var testHandicaps: [Handicap]?

                beforeEach {
                    let handicap = Handicap(features: [], name: "test", enabledIf: .allFeaturesEnabled)
                    testHandicaps = [handicap]
                    testStatuses = HandicapStatuses(withHandicaps: [], featureStatusesProvider: featureStatusesProviderMock!)
                    sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: testHandicaps!, featureStatusesProvider: featureStatusesProviderMock!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                }

                it("creates a HandicapNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(HandicapNotifications.self))
                }

                it("sets properties correctly") {
                    // swiftlint:disable force_cast
                    expect((sut!.statusesModule as! HandicapStatuses)).to(equal(testStatuses!))
                    expect((sut!.featureStatusesProvider as! FeatureStatusesProviderMock)).to(be(featureStatusesProviderMock!))
                    // swiftlint:enable force_cast
                    expect((sut!.targetNotificationCenter)).to(equal(targetNotificationCenterMock!))
                    expect((sut!.systemNotificationCenter)).to(equal(systemNotificationCenterMock!))
                }
            }

            context("after initialization with required initializer") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatuses?

                beforeEach {
                    testStatuses = HandicapStatuses(withHandicaps: [], featureStatusesProvider: featureStatusesProviderMock!)
                    sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [], featureStatusesProvider: featureStatusesProviderMock!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                }

                it("creates a HandicapNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(HandicapNotifications.self))
                }

                it("sets statuses property correctly") {
                    // swiftlint:disable force_cast
                    expect((sut!.statusesModule as! HandicapStatuses)).to(equal(testStatuses!))
                    expect((sut!.featureStatusesProvider as! FeatureStatusesProviderMock)).to(be(featureStatusesProviderMock!))
                    // swiftlint:enable force_cast
                    expect((sut!.targetNotificationCenter)).to(equal(targetNotificationCenterMock!))
                    expect((sut!.systemNotificationCenter)).to(equal(systemNotificationCenterMock!))
                }
            }

            context("after initialization with two Handicaps containing the same feature") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatuses?
                var testHandicap1: Handicap?
                var testHandicap2: Handicap?
                var testFeature: CapableFeature?

                beforeEach {
                    testFeature = .voiceOver
                    testHandicap1 = Handicap(features: [testFeature!], name: "testHandicap1", enabledIf: .oneFeatureEnabled)
                    testHandicap2 = Handicap(features: [testFeature!], name: "testHandicap2", enabledIf: .oneFeatureEnabled)
                    testStatuses = HandicapStatuses(withHandicaps: [testHandicap1!, testHandicap2!], featureStatusesProvider: featureStatusesProviderMock!)
                    sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [testHandicap1!, testHandicap2!], featureStatusesProvider: featureStatusesProviderMock!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                }

                #if os(iOS) || os(tvOS)

                it("registers itself as observer for the feature notification only once") {
                    expect(systemNotificationCenterMock!.observedNotifications).to(haveCount(1))
                    expect(systemNotificationCenterMock!.hasRegisteredNotification(forFeature: testFeature!)).to(beTrue())
                }

                #endif

                #if os(OSX)

                it("registers itself as observer for the display options notification only once") {
                    expect(systemNotificationCenterMock!.observedNotifications).to(haveCount(1))
                    expect(systemNotificationCenterMock!.hasRegisteredNotification(forName: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification)).to(beTrue())
                }

                }

                #endif

            }

            context("after initialization with a Handicap containing two features") {
                var sut: HandicapNotifications?
                var testStatuses: HandicapStatuses?
                var testHandicap: Handicap?
                var testFeature1: CapableFeature?
                var testFeature2: CapableFeature?

                beforeEach {
                    testFeature1 = .voiceOver
                    testFeature2 = .reduceMotion
                }

                context("when .enabledIf is set to .oneFeatureEnabled and both features are currently disabled") {
                    beforeEach {
                        testHandicap = Handicap(features: [testFeature1!, testFeature2!], name: "testHandicap", enabledIf: .oneFeatureEnabled)
                        testStatuses = HandicapStatuses(withHandicaps: [testHandicap!], featureStatusesProvider: featureStatusesProviderMock!)
                        featureStatusesProviderMock!.voiceOverEnabled = false
                        featureStatusesProviderMock!.reduceMotionEnabled = false
                        sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [testHandicap!], featureStatusesProvider: featureStatusesProviderMock!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                    }

                    afterEach {
                        featureStatusesProviderMock!.voiceOverEnabled = false
                        featureStatusesProviderMock!.reduceMotionEnabled = false
                    }

                    #if os(iOS) || os(tvOS)

                    it("registers itself as observer for both notifications") {
                        expect(systemNotificationCenterMock!.observedNotifications).to(haveCount(2))
                        expect(systemNotificationCenterMock!.hasRegisteredNotification(forFeature: testFeature1!)).to(beTrue())
                        expect(systemNotificationCenterMock!.hasRegisteredNotification(forFeature: testFeature2!)).to(beTrue())
                    }

                    #endif

                    #if os(OSX)

                    it("registers itself as observer for the display options notification (ReduceMotion)") {
                        expect(systemNotificationCenterMock!.observedNotifications).to(haveCount(1))
                        expect(systemNotificationCenterMock!.hasRegisteredNotification(forName: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification)).to(beTrue())
                    }


                    #endif

                    context("when features get enabled one by one") {
                        it("posts a CapableHandicapStatusDidChange notification with the correct HandicapStatus only if needed") {
                            // Enable feature 1 => a notification is posted with status "enabled"
                            featureStatusesProviderMock!.voiceOverEnabled = true
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "enabled")

                            // Enable feature 2 => no notification is posted
                            featureStatusesProviderMock!.reduceMotionEnabled = true
                            sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                            expect(notificationCenterMock!.postedNotifications.count).to(equal(1))

                            // Disable feature 2 => no notification is posted
                            featureStatusesProviderMock!.reduceMotionEnabled = false
                            sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                            expect(notificationCenterMock!.postedNotifications.count).to(equal(1))

                            // Disable feature 2 => a notification is posted with status "disabled"
                            featureStatusesProviderMock!.voiceOverEnabled = false
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "disabled")
                        }
                    }
                }

                context("when .enabledIf is set to .allFeaturesEnabled and both features are currently disabled") {
                    beforeEach {
                        testHandicap = Handicap(with: [testFeature1!, testFeature2!], name: "testHandicap", enabledIf: .allFeaturesEnabled)
                        testStatuses = HandicapStatuses(withHandicaps: [testHandicap!], featureStatusesProvider: featureStatusesProviderMock!)
                        featureStatusesProviderMock!.voiceOverEnabled = false
                        featureStatusesProviderMock!.reduceMotionEnabled = false
                        sut = HandicapNotifications(statusesModule: testStatuses!, handicaps: [testHandicap!], featureStatusesProvider: featureStatusesProviderMock!, notificationCenter: notificationCenterMock!)
                    }

                    afterEach {
                        featureStatusesProviderMock!.voiceOverEnabled = false
                        featureStatusesProviderMock!.reduceMotionEnabled = false
                    }

                    context("when features get enabled one by one") {
                        it("posts a CapableHandicapStatusDidChange notification with the correct HandicapStatus only if needed") {
                            // Enable feature 1 => no notification is posted
                            featureStatusesProviderMock!.voiceOverEnabled = true
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            expect(notificationCenterMock!.postedNotifications.count).to(equal(0))

                            // Enable feature 2 => a notification is posted with status "enabled"
                            featureStatusesProviderMock!.reduceMotionEnabled = true
                            sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "enabled")

                            // Disable feature 1 => a notification is posted with status "disabled"
                            featureStatusesProviderMock!.voiceOverEnabled = false
                            sut!.voiceOverStatusChanged(notification: placeholderNotification)
                            verifyHandicapDidChangeNotificationWasPosted(withHandicap: testHandicap!, statusString: "disabled")
                        }
                    }
                }
            }

            func verifyHandicapDidChangeNotificationWasPosted(withHandicap handicap: Handicap, statusString: String) {
                expect(notificationCenterMock!.postedNotifications.count).to(equal(1))

                let notificationObject = notificationCenterMock!.postedNotifications[handicapDidChangeNotification]
                guard let handicapStatus = notificationObject as? HandicapStatus else {
                    fail("Notification does not contain a HandicapStatus object.")
                    return
                }
                expect(handicapStatus.handicap).to(equal(handicap))
                expect(handicapStatus.statusString).to(equal(statusString))
            }
        }
    }
}

#endif
