//
//  AccessibilityFeatureProviderTests.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable
import Nimble
import Quick

class AccessibilityFeatureProviderTests: QuickSpec {
    override func spec() {
        describe("The AccessibilityFeatureProvider class") {
            var sut: AccessibilityFeatureProvider!
            
            context("after initialization") {
                beforeEach {
                    sut = AccessibilityFeatureProvider()
                }
                
                context("calling accessibilityFeature() with name assistiveTouch") {
                    it("returns an instance of type AssistiveTouch") {
                        expect(sut.accessibilityFeature(featureName: AssistiveTouch.name)).to(beAnInstanceOf(AssistiveTouch.self))
                    }
                }
                
                context("calling accessibilityFeature() with name boldText") {
                    it("returns an instance of type BoldText") {
                        expect(sut.accessibilityFeature(featureName: BoldText.name)).to(beAnInstanceOf(BoldText.self))
                    }
                }
                
                context("calling accessibilityFeature() with name closedCaptioning") {
                    it("returns an instance of type ClosedCaptioning") {
                        expect(sut.accessibilityFeature(featureName: ClosedCaptioning.name)).to(beAnInstanceOf(ClosedCaptioning.self))
                    }
                }
                
                context("calling accessibilityFeature() with name darkerSystemColors") {
                    it("returns an instance of type DarkerSystemColors") {
                        expect(sut.accessibilityFeature(featureName: DarkerSystemColors.name)).to(beAnInstanceOf(DarkerSystemColors.self))
                    }
                }
                
                context("calling accessibilityFeature() with name differentiateWithoutColor") {
                    it("returns an instance of type DifferentiateWithoutColor") {
                        expect(sut.accessibilityFeature(featureName: DifferentiateWithoutColor.name)).to(beAnInstanceOf(DifferentiateWithoutColor.self))
                    }
                }
                
                context("calling accessibilityFeature() with name fullKeyboardAccess") {
                    it("returns an instance of type FullKeyboardAccess") {
                        expect(sut.accessibilityFeature(featureName: FullKeyboardAccess.name)).to(beAnInstanceOf(FullKeyboardAccess.self))
                    }
                }
                
                context("calling accessibilityFeature() with name grayscale") {
                    it("returns an instance of type Grayscale") {
                        expect(sut.accessibilityFeature(featureName: Grayscale.name)).to(beAnInstanceOf(Grayscale.self))
                    }
                }
                
                context("calling accessibilityFeature() with name guidedAccess") {
                    it("returns an instance of type GuidedAccess") {
                        expect(sut.accessibilityFeature(featureName: GuidedAccess.name)).to(beAnInstanceOf(GuidedAccess.self))
                    }
                }
                
                context("calling accessibilityFeature() with name hearingDevicePairedEar") {
                    it("returns an instance of type HearingDevicePairedEar") {
                        expect(sut.accessibilityFeature(featureName: HearingDevicePairedEar.name)).to(beAnInstanceOf(HearingDevicePairedEar.self))
                    }
                }
                
                context("calling accessibilityFeature() with name increaseContrast") {
                    it("returns an instance of type IncreaseContrast") {
                        expect(sut.accessibilityFeature(featureName: IncreaseContrast.name)).to(beAnInstanceOf(IncreaseContrast.self))
                    }
                }
                
                context("calling accessibilityFeature() with name increaseContrast") {
                    it("returns an instance of type IncreaseContrast") {
                        expect(sut.accessibilityFeature(featureName: InvertColors.name)).to(beAnInstanceOf(InvertColors.self))
                    }
                }
                
                context("calling accessibilityFeature() with name largerText") {
                    it("returns an instance of type LargerText") {
                        expect(sut.accessibilityFeature(featureName: LargerText.name)).to(beAnInstanceOf(LargerText.self))
                    }
                }
                
                context("calling accessibilityFeature() with name monoAudio") {
                    it("returns an instance of type MonoAudio") {
                        expect(sut.accessibilityFeature(featureName: MonoAudio.name)).to(beAnInstanceOf(MonoAudio.self))
                    }
                }
                
                context("calling accessibilityFeature() with name onOffSwitchLabels") {
                    it("returns an instance of type OnOffSwitchLabels") {
                        expect(sut.accessibilityFeature(featureName: OnOffSwitchLabels.name)).to(beAnInstanceOf(OnOffSwitchLabels.self))
                    }
                }
                
                context("calling accessibilityFeature() with name reduceMotion") {
                    it("returns an instance of type ReduceMotion") {
                        expect(sut.accessibilityFeature(featureName: ReduceMotion.name)).to(beAnInstanceOf(ReduceMotion.self))
                    }
                }
                
                context("calling accessibilityFeature() with name reduceTransparency") {
                    it("returns an instance of type ReduceTransparency") {
                        expect(sut.accessibilityFeature(featureName: ReduceTransparency.name)).to(beAnInstanceOf(ReduceTransparency.self))
                    }
                }
                
                context("calling accessibilityFeature() with name shakeToUndo") {
                    it("returns an instance of type ShakeToUndo") {
                        expect(sut.accessibilityFeature(featureName: ShakeToUndo.name)).to(beAnInstanceOf(ShakeToUndo.self))
                    }
                }
                
                context("calling accessibilityFeature() with name speakScreen") {
                    it("returns an instance of type SpeakScreen") {
                        expect(sut.accessibilityFeature(featureName: SpeakScreen.name)).to(beAnInstanceOf(SpeakScreen.self))
                    }
                }
                
                context("calling accessibilityFeature() with name speakSelection") {
                    it("returns an instance of type SpeakSelection") {
                        expect(sut.accessibilityFeature(featureName: SpeakSelection.name)).to(beAnInstanceOf(SpeakSelection.self))
                    }
                }
                
                context("calling accessibilityFeature() with name switchControl") {
                    it("returns an instance of type SwitchControl") {
                        expect(sut.accessibilityFeature(featureName: SwitchControl.name)).to(beAnInstanceOf(SwitchControl.self))
                    }
                }
                
                context("calling accessibilityFeature() with name videoAutoplay") {
                    it("returns an instance of type VideoAutoplay") {
                        expect(sut.accessibilityFeature(featureName: VideoAutoplay.name)).to(beAnInstanceOf(VideoAutoplay.self))
                    }
                }
                
                context("calling accessibilityFeature() with name voiceOver") {
                    it("returns an instance of type VoiceOver") {
                        expect(sut.accessibilityFeature(featureName: VoiceOver.name)).to(beAnInstanceOf(VoiceOver.self))
                    }
                }
            }
        }
    }
}
#endif
