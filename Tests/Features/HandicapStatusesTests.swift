//
//  HandicapStatusesTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 05.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class HandicapStatusesTests: QuickSpec {
    override func spec() {
        describe("The HandicapStatuses class") {
            var sut: HandicapStatuses?
            var featureStatusesProviderMock: FeatureStatusesProviderMock?

            beforeEach {
                featureStatusesProviderMock = FeatureStatusesProviderMock()
            }

            context("after initialization with multiple handicaps") {
                var testHandicap1: Handicap?
                var testHandicap2: Handicap?

                beforeEach {
                    let testFeatures: [CapableFeature] = [.reduceMotion, .voiceOver]
                    testHandicap1 = Handicap(with: testFeatures, name: "TestHandicap1", enabledIf: .oneFeatureEnabled)
                    testHandicap2 = Handicap(with: testFeatures, name: "TestHandicap2", enabledIf: .allFeaturesEnabled)
                    sut = HandicapStatuses(withHandicaps: [testHandicap1!, testHandicap2!], featureStatusesProvider: featureStatusesProviderMock!)
                }

                it("creates a HandicapStatuses instance with all properties set ") {
                    expect(sut!).to(beAnInstanceOf(HandicapStatuses.self))
                    expect(sut!.handicapMap.count).to(equal(2))
                    expect(Array(sut!.handicapMap.keys)).to(contain([testHandicap1!.name, testHandicap2!.name]))
                    expect(sut!.handicapMap[testHandicap1!.name]).to(equal(testHandicap1))
                    expect(sut!.handicapMap[testHandicap2!.name]).to(equal(testHandicap2))
                    expect(sut!.featureStatusesProvider).to(be(featureStatusesProviderMock!))
                }

                context("when calling statusMap") {
                    var statusMap: [String: String]?

                    beforeEach {
                        featureStatusesProviderMock!.enableAllFeatures()
                        statusMap = sut!.statusMap
                    }

                    it("returns a status map containing all features") {
                        expect(statusMap!.count).to(equal(2))
                        expect(Array(statusMap!.keys)).to(contain([testHandicap1!.name, testHandicap2!.name]))
                    }

                    it("returns a status map containing the correct statuses") {
                        for key in statusMap!.keys {
                            expect(statusMap![key]).to(equal("enabled"))
                        }
                    }
                }

                context("when calling isHandicapEnabled") {
                    context("when requested Handicap has not been registered") {

                        beforeEach {
                            featureStatusesProviderMock!.enableAllFeatures()
                        }

                        it("returns false") {
                            expect(sut!.isHandicapEnabled(handicapName: "notAvailable")).to(beFalse())
                        }
                    }

                    context("when enabledIf is set to .allFeaturesEnabled") {
                        var testHandicap: Handicap?

                        beforeEach {
                            testHandicap = testHandicap2
                        }

                        context("when all features are enabled") {
                            beforeEach {
                                featureStatusesProviderMock!.reduceMotionEnabled = true
                                featureStatusesProviderMock!.voiceOverEnabled = true
                            }

                            it("returns true") {
                                expect(sut!.isHandicapEnabled(handicapName: testHandicap!.name)).to(beTrue())
                            }
                        }

                        context("when one features is enabled") {
                            beforeEach {
                                featureStatusesProviderMock!.reduceMotionEnabled = true
                                featureStatusesProviderMock!.voiceOverEnabled = false
                            }

                            it("returns false") {
                                expect(sut!.isHandicapEnabled(handicapName: testHandicap!.name)).to(beFalse())
                            }
                        }
                    }

                    context("when enabledIf is set to .oneFeatureEnabled") {
                        var testHandicap: Handicap?

                        beforeEach {
                            testHandicap = testHandicap1
                        }

                        context("when one features are enabled") {
                            beforeEach {
                                featureStatusesProviderMock!.reduceMotionEnabled = true
                                featureStatusesProviderMock!.voiceOverEnabled = false
                            }

                            it("returns true") {
                                expect(sut!.isHandicapEnabled(handicapName: testHandicap!.name)).to(beTrue())
                            }
                        }

                        context("when no features is enabled") {
                            beforeEach {
                                featureStatusesProviderMock!.reduceMotionEnabled = false
                                featureStatusesProviderMock!.voiceOverEnabled = false
                            }

                            it("returns false") {
                                expect(sut!.isHandicapEnabled(handicapName: testHandicap!.name)).to(beFalse())
                            }
                        }
                    }
                }
            }

            #if os(iOS)
            context("after initialization with a Handicap holding the .largerText feature") {
                var testHandicapName: String?

                beforeEach {
                    testHandicapName = "TestHandicap"
                    let testHandicap = Handicap(with: [.largerText], name: testHandicapName!, enabledIf: .allFeaturesEnabled)
                    let testTextCategory: UIContentSizeCategory = .accessibilityExtraExtraExtraLarge
                    featureStatusesProviderMock!.textCatagory = testTextCategory
                    sut = HandicapStatuses(withHandicaps: [testHandicap], featureStatusesProvider: featureStatusesProviderMock!)
                }

                it("returns a status map containing enabled/disabled rather than the actual text category for the Handicap") {
                    let statusMap = sut!.statusMap
                    expect(statusMap[testHandicapName!]).to(equal("enabled"))
                }
            }
            #endif
        }
    }
}

#endif
