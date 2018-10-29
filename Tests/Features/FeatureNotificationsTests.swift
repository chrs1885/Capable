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
            var targetNotificationCenterMock: NotificationCenterMock?
            var systemNotificationCenterMock: NotificationCenterMock?
            var featureStatusesProviderMock: FeatureStatusesProviderMock?

            beforeEach {
                targetNotificationCenterMock = NotificationCenterMock()
                systemNotificationCenterMock = NotificationCenterMock()
                featureStatusesProviderMock = FeatureStatusesProviderMock()
            }

            context("after initialization") {
                var sut: FeatureNotifications?
                var testFeatures: [CapableFeature]?

                beforeEach {
                    testFeatures = []
                    sut = FeatureNotifications(featureStatusesProvider: featureStatusesProviderMock!, features: testFeatures!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                }

                it("creates a FeatureNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(FeatureNotifications.self))
                }

                it("sets properties correctly") {
                    // swiftlint:disable force_cast
                    expect((sut!.featureStatusesProvider as! FeatureStatusesProviderMock)).to(be(featureStatusesProviderMock!))
                    // swiftlint:enable force_cast
                    expect((sut!.targetNotificationCenter)).to(equal(targetNotificationCenterMock!))
                    expect((sut!.systemNotificationCenter)).to(equal(systemNotificationCenterMock!))
                }
            }

            context("after initialization with required initializer") {
                var sut: FeatureNotifications?

                beforeEach {
                    sut = FeatureNotifications(featureStatusesProvider: featureStatusesProviderMock!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                }

                it("creates a FeatureNotifications intsance") {
                    expect(sut!).to(beAnInstanceOf(FeatureNotifications.self))
                }

                it("sets statuses property correctly") {
                    // swiftlint:disable force_cast
                    expect((sut!.featureStatusesProvider as! FeatureStatusesProviderMock)).to(be(featureStatusesProviderMock!))
                    // swiftlint:enable force_cast
                    expect((sut!.targetNotificationCenter)).to(equal(targetNotificationCenterMock!))
                    expect((sut!.systemNotificationCenter)).to(equal(systemNotificationCenterMock!))
                }
            }

            #if os(iOS) || os(tvOS) || os(OSX)

            context("after initialization with all features available") {
                var sut: FeatureNotifications?
                var testFeatures: [CapableFeature]?

                beforeEach {
                    testFeatures = CapableFeature.allCases
                    sut = FeatureNotifications(featureStatusesProvider: featureStatusesProviderMock!, features: testFeatures!, targetNotificationCenter: targetNotificationCenterMock!, systemNotificationCenter: systemNotificationCenterMock!)
                }

                #if os(iOS) || os(tvOS)

                it("registers itself as observer for feature related notifications") {
                    expect(systemNotificationCenterMock!.observedNotifications).to(haveCount(testFeatures!.count))
                    for feature in testFeatures! {
                        expect(systemNotificationCenterMock!.hasRegisteredNotification(forFeature: feature)).to(beTrue())
                    }
                }

                #if os(iOS)

                context("when AssistiveTouch was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.assistiveTouchEnabled = true
                        sut!.assistiveTouchStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .assistiveTouch, statusString: "enabled")
                    }
                }

                context("when DarkerSystemColors was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.darkerSystemColorsEnabled = true
                        sut!.darkerSystemColorsStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .darkerSystemColors, statusString: "enabled")
                    }
                }

                context("when GuidedAccess was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.guidedAccessEnabled = true
                        sut!.guidedAccessStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .guidedAccess, statusString: "enabled")
                    }
                }

                context("when InvertColors was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.invertColorsEnabled = true
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
                        featureStatusesProviderMock!.textCatagory = testContentSizeCategory!
                        sut!.largerTextStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .largerText, statusString: testContentSizeCategory!.stringValue)
                    }
                }

                context("when ShakeToUndo was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.shakeToUndoEnabled = true
                        sut!.shakeToUndoStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .shakeToUndo, statusString: "enabled")
                    }
                }

                context("when SpeakScreen was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.speakScreenEnabled = true
                        sut!.speakScreenStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .speakScreen, statusString: "enabled")
                    }
                }

                context("when SpeackSelection was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.speakSelectionEnabled = true
                        sut!.speakSelectionStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .speakSelection, statusString: "enabled")
                    }
                }

                #endif

                context("when BoldText was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.boldTextEnabled = true
                        sut!.boldTextStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .boldText, statusString: "enabled")
                    }
                }

                context("when ClosedCaptioning was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.closedCaptioningEnabled = true
                        sut!.closedCaptioningStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .closedCaptioning, statusString: "enabled")
                    }
                }

                context("when Grayscale was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.grayscaleEnabled = true
                        sut!.grayscaleStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .grayscale, statusString: "enabled")
                    }
                }

                context("when MonoAudio was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.monoAudioEnabled = true
                        sut!.monoAudioStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .monoAudio, statusString: "enabled")
                    }
                }

                context("when SwitchControl was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.switchControlEnabled = true
                        sut!.switchControlStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .switchControl, statusString: "enabled")
                    }
                }

                context("when ReduceTransparency was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.reduceTransparencyEnabled = true
                        sut!.reduceTransparencyStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .reduceTransparency, statusString: "enabled")
                    }
                }

                context("when ReduceMotion was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.reduceMotionEnabled = true
                        sut!.reduceMotionStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .reduceMotion, statusString: "enabled")
                    }
                }

                context("when VoiceOver was activated by the user") {
                    beforeEach {
                        featureStatusesProviderMock!.voiceOverEnabled = true
                        sut!.voiceOverStatusChanged(notification: placeholderNotification)
                    }

                    it("posts a CapableFeatureStatusDidChange notification with the correct FeatureStatus") {
                        verifyFeatureDidChangeNotificationWasPosted(withFeature: .voiceOver, statusString: "enabled")
                    }
                }
            }

            func verifyFeatureDidChangeNotificationWasPosted(withFeature feature: CapableFeature, statusString: String) {
                expect(notificationCenterMock!.postedNotifications.count).to(equal(1))

                let notificationObject = notificationCenterMock!.postedNotifications[featureDidChangeNotification]
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
