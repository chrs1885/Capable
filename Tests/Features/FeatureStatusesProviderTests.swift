//
//  FeatureStatusesProviderTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 06.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class FeatureStatusesProviderTests: QuickSpec {
    override func spec() {
        describe("The FeatureStatusesProvider class") {
            var sut: FeatureStatusesProviderMock?

            beforeEach {
                sut = FeatureStatusesProviderMock()
            }

            context("when calling isFeatureEnabled") {

                #if os(iOS)
                context("for AssistiveTouch") {
                    beforeEach {
                        sut!.assistiveTouchEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .assistiveTouch)).to(beTrue())
                    }
                }

                context("for DarkerSystemColors") {
                    beforeEach {
                        sut!.darkerSystemColorsEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .darkerSystemColors)).to(beTrue())
                    }
                }

                context("for GuidedAccess") {
                    beforeEach {
                        sut!.guidedAccessEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .guidedAccess)).to(beTrue())
                    }
                }

                context("for InvertColors") {
                    beforeEach {
                        sut!.invertColorsEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .invertColors)).to(beTrue())
                    }
                }

                context("for LargerText") {
                    beforeEach {
                        sut!.textCatagory = .accessibilityLarge
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .largerText)).to(beTrue())
                    }
                }

                context("for ShakeToUndo") {
                    beforeEach {
                        sut!.shakeToUndoEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .shakeToUndo)).to(beTrue())
                    }
                }

                context("for SpeakScreen") {
                    beforeEach {
                        sut!.speakScreenEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .speakScreen)).to(beTrue())
                    }
                }

                context("for SpeakSelection") {
                    beforeEach {
                        sut!.speakSelectionEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .speakSelection)).to(beTrue())
                    }
                }
                #endif

                #if os(OSX)
                context("for DifferentiateWithoutColor") {
                    beforeEach {
                        sut!.differentiateWithoutColor = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .differentiateWithoutColor)).to(beTrue())
                    }
                }

                context("for IncreaseContrast") {
                    beforeEach {
                        sut!.increaseContrast = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .increaseContrast)).to(beTrue())
                    }
                }
                #endif

                #if os(iOS) || os(tvOS)
                context("for BoldText") {
                    beforeEach {
                        sut!.boldTextEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .boldText)).to(beTrue())
                    }
                }

                context("for ClosedCaptioning") {
                    beforeEach {
                        sut!.closedCaptioningEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .closedCaptioning)).to(beTrue())
                    }
                }

                context("for Grayscale") {
                    beforeEach {
                        sut!.grayscaleEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .grayscale)).to(beTrue())
                    }
                }

                context("for MonoAudio") {
                    beforeEach {
                        sut!.monoAudioEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .monoAudio)).to(beTrue())
                    }
                }
                #endif

                context("for ReduceMotion") {
                    beforeEach {
                        sut!.reduceMotionEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .reduceMotion)).to(beTrue())
                    }
                }

                context("for ReduceTransparency") {
                    beforeEach {
                        sut!.reduceTransparencyEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .reduceTransparency)).to(beTrue())
                    }
                }

                context("for SwitchControl") {
                    beforeEach {
                        sut!.switchControlEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .switchControl)).to(beTrue())
                    }
                }

                context("for VoiceOver") {
                    beforeEach {
                        sut!.voiceOverEnabled = true
                    }

                    it("returns correct state") {
                        expect(sut!.isFeatureEnabled(feature: .voiceOver)).to(beTrue())
                    }
                }
            }
        }
    }
}

#endif
