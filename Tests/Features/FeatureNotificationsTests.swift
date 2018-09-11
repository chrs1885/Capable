//
//  FeatureNotificationsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 24.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class FeatureNotificationsTests: QuickSpec {
    override func spec() {
        describe("The FeatureNotifications class") {
            let featureDidChangeNotification = Notification.Name.CapableFeatureStatusDidChange
            var notificationCenterMock: NotificationCenterMock?

            beforeEach {
                notificationCenterMock = NotificationCenterMock()
            }

            afterEach {
                notificationCenterMock = nil
            }

            context("after initialization") {
                var sut: FeatureNotifications?
                var testStatuses: FeatureStatusesMock?
                var testFeatures: [CapableFeature]?

                beforeEach {
                    testFeatures = []
                    testStatuses = FeatureStatusesMock(withFeatures: testFeatures!)
                    sut = FeatureNotifications(statusesModule: testStatuses!, features: testFeatures!, notificationCenter: notificationCenterMock!)
                }

                it("creates a FeatureNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(FeatureNotifications.self))
                }

                // swiftlint:disable force_cast
                it("sets properties correctly") {
                    expect((sut!.statusesModule as! FeatureStatusesMock)).to(equal(testStatuses!))
                    expect((sut!.notificationCenter)).to(equal(notificationCenterMock!))
                }
                // swiftlint:enable force_cast
            }

            context("after initialization with required initializer") {
                var sut: FeatureNotifications?
                var testStatuses: FeatureStatusesMock?

                beforeEach {
                    testStatuses = FeatureStatusesMock(withFeatures: [])
                    sut = FeatureNotifications(statusesModule: testStatuses!, notificationCenter: notificationCenterMock!)
                }

                it("creates a FeatureNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(FeatureNotifications.self))
                }

                // swiftlint:disable force_cast
                it("sets statuses property correctly") {
                    expect((sut!.statusesModule as! FeatureStatusesMock)).to(equal(testStatuses!))
                    expect((sut!.notificationCenter)).to(equal(notificationCenterMock!))
                }
                // swiftlint:enable force_cast
            }

            #if os(iOS) || os(tvOS)

            let placeholderNotification = NSNotification(name: .UIAccessibilitySpeakScreenStatusDidChange, object: nil)

            context("after initialization with all features available") {
                var sut: FeatureNotifications?
                var testStatuses: FeatureStatusesMock?
                var testFeatures: [CapableFeature]?

                beforeEach {
                    testFeatures = CapableFeature.allValues()
                    testStatuses = FeatureStatusesMock(withFeatures: testFeatures!)
                    sut = FeatureNotifications(statusesModule: testStatuses!, features: testFeatures!, notificationCenter: notificationCenterMock!)
                }

                it("registers itself as observer for feature related notifications") {
                    expect(notificationCenterMock?.observedNotifications.count).to(equal(testFeatures!.count))
                    for feature in testFeatures! {
                        expect(notificationCenterMock?.hasRegisteredNotification(forFeature: feature)).to(beTrue())
                    }
                }

                #if os(iOS)

                context("when AssistiveTouch was activated by the user") {
                    beforeEach {
                        testStatuses?.assistiveTouchEnabled = true
                        sut!.assistiveTouchStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .assistiveTouch, statusString: "enabled")
                    }
                }

                context("when DarkerSystemColors was activated by the user") {
                    beforeEach {
                        testStatuses?.darkerSystemColorsEnabled = true
                        sut!.darkerSystemColorsStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .darkerSystemColors, statusString: "enabled")
                    }
                }

                context("when GuidedAccess was activated by the user") {
                    beforeEach {
                        testStatuses?.guidedAccessEnabled = true
                        sut!.guidedAccessStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .guidedAccess, statusString: "enabled")
                    }
                }

                context("when InvertColors was activated by the user") {
                    beforeEach {
                        testStatuses?.invertColorsEnabled = true
                        sut!.invertColorsStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .invertColors, statusString: "enabled")
                    }
                }

                context("when LargerText was activated by the user") {
                    var testContentSizeCategory: UIContentSizeCategory?

                    beforeEach {
                        testContentSizeCategory = .accessibilityExtraExtraExtraLarge
                        testStatuses?.textCatagory = testContentSizeCategory!
                        sut!.largerTextStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .largerText, statusString: testContentSizeCategory!.stringValue)
                    }
                }

                context("when ShakeToUndo was activated by the user") {
                    beforeEach {
                        testStatuses?.shakeToUndoEnabled = true
                        sut!.shakeToUndoStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .shakeToUndo, statusString: "enabled")
                    }
                }

                context("when SpeakScreen was activated by the user") {
                    beforeEach {
                        testStatuses?.speakScreenEnabled = true
                        sut!.speakScreenStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .speakScreen, statusString: "enabled")
                    }
                }

                context("when SpeackSelection was activated by the user") {
                    beforeEach {
                        testStatuses?.speakSelectionEnabled = true
                        sut!.speakSelectionStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .speakSelection, statusString: "enabled")
                    }
                }

                #endif

                context("when BoldText was activated by the user") {
                    beforeEach {
                        testStatuses?.boldTextEnabled = true
                        sut!.boldTextStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .boldText, statusString: "enabled")
                    }
                }

                context("when ClosedCaptioning was activated by the user") {
                    beforeEach {
                        testStatuses?.closedCaptioningEnabled = true
                        sut!.closedCaptioningStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .closedCaptioning, statusString: "enabled")
                    }
                }

                context("when Grayscale was activated by the user") {
                    beforeEach {
                        testStatuses?.grayscaleEnabled = true
                        sut!.grayscaleStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .grayscale, statusString: "enabled")
                    }
                }

                context("when MonoAudio was activated by the user") {
                    beforeEach {
                        testStatuses?.monoAudioEnabled = true
                        sut!.monoAudioStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .monoAudio, statusString: "enabled")
                    }
                }

                context("when SwitchControl was activated by the user") {
                    beforeEach {
                        testStatuses?.switchControlEnabled = true
                        sut!.switchControlStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .switchControl, statusString: "enabled")
                    }
                }

                context("when ReduceTransparency was activated by the user") {
                    beforeEach {
                        testStatuses?.reduceTransparencyEnabled = true
                        sut!.reduceTransparencyStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .reduceTransparency, statusString: "enabled")
                    }
                }

                context("when ReduceMotion was activated by the user") {
                    beforeEach {
                        testStatuses?.reduceMotionEnabled = true
                        sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .reduceMotion, statusString: "enabled")
                    }
                }

                context("when VoiceOver was activated by the user") {
                    beforeEach {
                        testStatuses?.voiceOverEnabled = true
                        sut!.voiceOverStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .voiceOver, statusString: "enabled")
                    }
                }
            }

            func verifyFeatureDidChangeNotificationWasPosted(withFeature feature: CapableFeature, statusString: String) {
                expect(notificationCenterMock?.postedNotifications.count).to(equal(1))

                let notificationObject = notificationCenterMock?.postedNotifications[featureDidChangeNotification]
                guard let featureStatus = notificationObject as? FeatureStatus else {
                    fail("Notification does not contain a FeatureStatus object.")
                    return
                }
                expect(featureStatus.feature).to(equal(feature))
                expect(featureStatus.statusString).to(equal(statusString))
            }

            #endif

        }
    }
}

#endif
