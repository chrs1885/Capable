//
//  CapableTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.03.18.
//
#if os(iOS) || os(tvOS)
import Quick
import Nimble
@testable import Capable

class CapableSpec: QuickSpec {
    override func spec() {
        describe("the Capable class") {
            context("after default initialization") {
                var sut: Capable?

                beforeEach {
                    sut = Capable()
                }

                it("returns a status map with all features") {
                    let statusMap = sut!.statusMap
                    expect(statusMap.count).to(equal(CapableFeature.allValues().count))
                    expect(Array(statusMap.keys)).to(contain(CapableFeature.keys(forFeatures: CapableFeature.allValues())))
                }
            }

            context("after initialization with specific features") {
                var sut: Capable?
                let testedFeatures: [CapableFeature] = [.boldText, .reduceMotion]
                
                beforeEach() {
                    sut = Capable(with: testedFeatures)
                }

                it("returns a status map with features that were registered") {
                    let statusMap = sut!.statusMap
                    expect(statusMap.count).to(equal(testedFeatures.count))
                    expect(Array(statusMap.keys)).to(contain(CapableFeature.keys(forFeatures: testedFeatures)))
                }
            }

            context("after initialization") {
                var sut: Capable?
                var notificationsMock: NotificationsMock?
                var statusesMock: StatusesMock?

                beforeEach {
                    statusesMock = StatusesMock()
                    notificationsMock = NotificationsMock(statusesModule: statusesMock!)
                    sut = Capable(with: statusesMock!, notificationModule: notificationsMock!)
                }

                it("enables notifications") {
                    expect(notificationsMock!.numEnableNotificationsCalled).to(equal(1))
                }

                context("when setting notificationsEnabled to true") {
                    it("does not register notifications again") {
                        sut?.notificationsEnabled = true
                        expect(notificationsMock!.numEnableNotificationsCalled).to(equal(1))
                    }
                }

                context("when setting notificationsEnabled to false") {
                    it("does unregister Notifications") {
                        sut?.notificationsEnabled = false
                        expect(notificationsMock!.numDisableNotificationsCalled).to(equal(1))
                    }
                }

                context("when setting notificationsEnabled to false again") {
                    it("does not unregister Notifications again") {
                        sut?.notificationsEnabled = false
                        expect(notificationsMock!.numDisableNotificationsCalled).to(equal(1))
                    }
                }
            }

            context("when calling isFeatureEnabled") {
                var sut: Capable?
                var notificationsMock: NotificationsMock?
                var statusesMock: StatusesMock?

                beforeEach {
                    statusesMock = StatusesMock()
                    notificationsMock = NotificationsMock(statusesModule: statusesMock!)
                    sut = Capable(with: statusesMock!, notificationModule: notificationsMock!)
                }

                #if os(iOS)
                context("for AssistiveTouch") {
                    beforeEach {
                       statusesMock?.assistiveTouchEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .assistiveTouch)).to(beTrue())
                    }
                }

                context("for DarkerSystemColors") {
                    beforeEach {
                        statusesMock?.darkerSystemColorsEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .darkerSystemColors)).to(beTrue())
                    }
                }

                context("for GuidedAccess") {
                    beforeEach {
                        statusesMock?.guidedAccessEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .guidedAccess)).to(beTrue())
                    }
                }

                context("for InvertColors") {
                    beforeEach {
                        statusesMock?.invertColorsEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .invertColors)).to(beTrue())
                    }
                }

                context("for LargerText") {
                    beforeEach {
                        statusesMock?.textCatagory = .accessibilityLarge
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .largerText)).to(beTrue())
                    }
                }

                context("for ShakeToUndo") {
                    beforeEach {
                        statusesMock?.shakeToUndoEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .shakeToUndo)).to(beTrue())
                    }
                }

                context("for SpeakScreen") {
                    beforeEach {
                        statusesMock?.speakScreenEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .speakScreen)).to(beTrue())
                    }
                }

                context("for SpeakSelection") {
                    beforeEach {
                        statusesMock?.speakSelectionEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .speakSelection)).to(beTrue())
                    }
                }
                #endif

                context("for BoldText") {
                    beforeEach {
                        statusesMock?.boldTextEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .boldText)).to(beTrue())
                    }
                }

                context("for ClosedCaptioning") {
                    beforeEach {
                        statusesMock?.closedCaptioningEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .closedCaptioning)).to(beTrue())
                    }
                }

                context("for Grayscale") {
                    beforeEach {
                        statusesMock?.grayscaleEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .grayscale)).to(beTrue())
                    }
                }

                context("for MonoAudio") {
                    beforeEach {
                        statusesMock?.monoAudioEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .monoAudio)).to(beTrue())
                    }
                }

                context("for ReduceMotion") {
                    beforeEach {
                        statusesMock?.reduceMotionEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .reduceMotion)).to(beTrue())
                    }
                }

                context("for ReduceTransparency") {
                    beforeEach {
                        statusesMock?.reduceTransparencyEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .reduceTransparency)).to(beTrue())
                    }
                }

                context("for SwitchControl") {
                    beforeEach {
                        statusesMock?.switchControlEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .switchControl)).to(beTrue())
                    }
                }

                context("for VoiceOver") {
                    beforeEach {
                        statusesMock?.voiceOverEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut?.isFeatureEnabled(feature: .voiceOver)).to(beTrue())
                    }
                }
            }
        }
    }
}
#endif
