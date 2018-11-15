//
//  FeatureStatusesTest.swift
//  CapableTests
//
//  Created by Christoph Wendt on 05.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class FeatureStatusesTests: QuickSpec {
    override func spec() {
        describe("The FeatureStatuses class") {
            var featureStatusesProviderMock: FeatureStatusesProviderMock?

            beforeEach {
                featureStatusesProviderMock = FeatureStatusesProviderMock()
            }

            context("after initialization with all features") {
                var sut: FeatureStatuses?
                var testFeatures: [CapableFeature]?

                beforeEach {
                    testFeatures = CapableFeature.allCases
                    sut = FeatureStatuses(withFeatures: testFeatures!, featureStatusesProvider: featureStatusesProviderMock!)
                }

                it("creates a FeatureStatuses instance with all properties set ") {
                    expect(sut!).to(beAnInstanceOf(FeatureStatuses.self))
                    expect(sut!.features).to(equal(testFeatures))
                    expect(sut!.featureStatusesProvider).to(be(featureStatusesProviderMock!))
                }

                context("when calling statusMap") {
                    var statusMap: [String: String]?

                    beforeEach {
                        featureStatusesProviderMock!.enableAllFeatures()
                        statusMap = sut!.statusMap
                    }

                    it("returns a status map containing all features") {
                        expect(statusMap!.count).to(equal(testFeatures!.count))
                        expect(Array(statusMap!.keys)).to(contain(CapableFeature.keys(forFeatures: testFeatures!)))
                    }

                    it("returns a status map containing the correct statuses") {
                        for key in statusMap!.keys {
                            #if os(iOS)

                            if key == CapableFeature.largerText.rawValue {
                                expect(statusMap![key]).to(equal("Accessibility XXXL"))
                            } else if key == CapableFeature.hearingDevice.rawValue {
                                expect(statusMap![key]).to(equal("both"))
                            } else {
                                expect(statusMap![key]).to(equal("enabled"))
                            }

                            #else

                            expect(statusMap![key]).to(equal("enabled"))

                            #endif
                        }
                    }
                }
            }

            context("when checking equality of two instances") {
                var featureStatuses1: FeatureStatuses?
                var featureStatuses2: FeatureStatuses?

                context("when they are holding different features") {
                    beforeEach {
                        featureStatuses1 = FeatureStatuses(withFeatures: [.voiceOver], featureStatusesProvider: FeatureStatusesProvider())
                        featureStatuses2 = FeatureStatuses(withFeatures: [.reduceMotion], featureStatusesProvider: FeatureStatusesProvider())
                    }

                    it("returns false") {
                        expect(featureStatuses1 == featureStatuses2).to(beFalse())
                    }
                }

                context("when they use different feature status provider implementations") {
                    beforeEach {
                        featureStatuses1 = FeatureStatuses(withFeatures: [.voiceOver], featureStatusesProvider: featureStatusesProviderMock!)
                        featureStatuses2 = FeatureStatuses(withFeatures: [.voiceOver], featureStatusesProvider: FeatureStatusesProvider())
                    }

                    it("returns false") {
                        expect(featureStatuses1 == featureStatuses2).to(beFalse())
                    }
                }

                context("when they are holding the same features and using the same feature status provider implementation") {
                    beforeEach {
                        featureStatuses1 = FeatureStatuses(withFeatures: [.voiceOver], featureStatusesProvider: FeatureStatusesProvider())
                        featureStatuses2 = FeatureStatuses(withFeatures: [.voiceOver], featureStatusesProvider: FeatureStatusesProvider())
                    }

                    it("returns true") {
                        expect(featureStatuses1 == featureStatuses2).to(beTrue())
                    }
                }
            }
        }
    }
}

#endif
