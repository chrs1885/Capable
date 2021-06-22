//
//  FeatureProviderTests.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable
    import Nimble
    import Quick

    class FeatureProviderTests: QuickSpec {
        override func spec() {
            describe("The FeatureProvider class") {
                var sut: FeatureProvider!

                context("after initialization") {
                    beforeEach {
                        sut = FeatureProvider()
                    }

                    context("calling feature() with name assistiveTouch") {
                        it("returns an instance of type AssistiveTouch") {
                            expect(sut.feature(featureName: AssistiveTouch.name)).to(beAnInstanceOf(AssistiveTouch.self))
                        }
                    }

                    context("calling feature() with name boldText") {
                        it("returns an instance of type BoldText") {
                            expect(sut.feature(featureName: BoldText.name)).to(beAnInstanceOf(BoldText.self))
                        }
                    }

                    context("calling feature() with name buttonShapes") {
                        it("returns an instance of type ButtonShapes") {
                            expect(sut.feature(featureName: ButtonShapes.name)).to(beAnInstanceOf(ButtonShapes.self))
                        }
                    }

                    context("calling feature() with name closedCaptioning") {
                        it("returns an instance of type ClosedCaptioning") {
                            expect(sut.feature(featureName: ClosedCaptioning.name)).to(beAnInstanceOf(ClosedCaptioning.self))
                        }
                    }

                    context("calling feature() with name darkerSystemColors") {
                        it("returns an instance of type DarkerSystemColors") {
                            expect(sut.feature(featureName: DarkerSystemColors.name)).to(beAnInstanceOf(DarkerSystemColors.self))
                        }
                    }

                    context("calling feature() with name differentiateWithoutColor") {
                        it("returns an instance of type DifferentiateWithoutColor") {
                            expect(sut.feature(featureName: DifferentiateWithoutColor.name)).to(beAnInstanceOf(DifferentiateWithoutColor.self))
                        }
                    }

                    context("calling feature() with name fullKeyboardAccess") {
                        it("returns an instance of type FullKeyboardAccess") {
                            expect(sut.feature(featureName: FullKeyboardAccess.name)).to(beAnInstanceOf(FullKeyboardAccess.self))
                        }
                    }

                    context("calling feature() with name grayscale") {
                        it("returns an instance of type Grayscale") {
                            expect(sut.feature(featureName: Grayscale.name)).to(beAnInstanceOf(Grayscale.self))
                        }
                    }

                    context("calling feature() with name guidedAccess") {
                        it("returns an instance of type GuidedAccess") {
                            expect(sut.feature(featureName: GuidedAccess.name)).to(beAnInstanceOf(GuidedAccess.self))
                        }
                    }

                    context("calling feature() with name hearingDevicePairedEar") {
                        it("returns an instance of type HearingDevicePairedEar") {
                            expect(sut.feature(featureName: HearingDevicePairedEar.name)).to(beAnInstanceOf(HearingDevicePairedEar.self))
                        }
                    }

                    context("calling feature() with name increaseContrast") {
                        it("returns an instance of type IncreaseContrast") {
                            expect(sut.feature(featureName: IncreaseContrast.name)).to(beAnInstanceOf(IncreaseContrast.self))
                        }
                    }

                    context("calling feature() with name increaseContrast") {
                        it("returns an instance of type IncreaseContrast") {
                            expect(sut.feature(featureName: InvertColors.name)).to(beAnInstanceOf(InvertColors.self))
                        }
                    }

                    context("calling feature() with name largerText") {
                        it("returns an instance of type LargerText") {
                            expect(sut.feature(featureName: LargerText.name)).to(beAnInstanceOf(LargerText.self))
                        }
                    }

                    context("calling feature() with name monoAudio") {
                        it("returns an instance of type MonoAudio") {
                            expect(sut.feature(featureName: MonoAudio.name)).to(beAnInstanceOf(MonoAudio.self))
                        }
                    }

                    context("calling feature() with name onOffSwitchLabels") {
                        it("returns an instance of type OnOffSwitchLabels") {
                            expect(sut.feature(featureName: OnOffSwitchLabels.name)).to(beAnInstanceOf(OnOffSwitchLabels.self))
                        }
                    }

                    context("calling feature() with name prefersCrossFadeTransitions") {
                        it("returns an instance of type PrefersCrossFadeTransitions") {
                            expect(sut.feature(featureName: PrefersCrossFadeTransitions.name)).to(beAnInstanceOf(PrefersCrossFadeTransitions.self))
                        }
                    }

                    context("calling feature() with name reduceMotion") {
                        it("returns an instance of type ReduceMotion") {
                            expect(sut.feature(featureName: ReduceMotion.name)).to(beAnInstanceOf(ReduceMotion.self))
                        }
                    }

                    context("calling feature() with name reduceTransparency") {
                        it("returns an instance of type ReduceTransparency") {
                            expect(sut.feature(featureName: ReduceTransparency.name)).to(beAnInstanceOf(ReduceTransparency.self))
                        }
                    }

                    context("calling feature() with name shakeToUndo") {
                        it("returns an instance of type ShakeToUndo") {
                            expect(sut.feature(featureName: ShakeToUndo.name)).to(beAnInstanceOf(ShakeToUndo.self))
                        }
                    }

                    context("calling feature() with name speakScreen") {
                        it("returns an instance of type SpeakScreen") {
                            expect(sut.feature(featureName: SpeakScreen.name)).to(beAnInstanceOf(SpeakScreen.self))
                        }
                    }

                    context("calling feature() with name speakSelection") {
                        it("returns an instance of type SpeakSelection") {
                            expect(sut.feature(featureName: SpeakSelection.name)).to(beAnInstanceOf(SpeakSelection.self))
                        }
                    }

                    context("calling feature() with name switchControl") {
                        it("returns an instance of type SwitchControl") {
                            expect(sut.feature(featureName: SwitchControl.name)).to(beAnInstanceOf(SwitchControl.self))
                        }
                    }

                    context("calling feature() with name videoAutoplay") {
                        it("returns an instance of type VideoAutoplay") {
                            expect(sut.feature(featureName: VideoAutoplay.name)).to(beAnInstanceOf(VideoAutoplay.self))
                        }
                    }

                    context("calling feature() with name voiceOver") {
                        it("returns an instance of type VoiceOver") {
                            expect(sut.feature(featureName: VoiceOver.name)).to(beAnInstanceOf(VoiceOver.self))
                        }
                    }
                }
            }
        }
    }
#endif
