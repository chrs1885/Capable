//
//  CapableTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.03.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable
    import Nimble
    import Quick

    class CapableTests: QuickSpec {
        override func spec() {
            describe("The Capable class") {
                var sut: Capable!

                context("after initialization with features") {
                    context("when providing specific features") {
                        var testedFeatures: [CapableFeature]!

                        beforeEach {
                            testedFeatures = [.reduceMotion, .voiceOver]
                            sut = Capable(withFeatures: testedFeatures)
                        }

                        it("creates a Capable instance") {
                            expect(sut).to(beAnInstanceOf(Capable.self))
                        }

                        it("initializes its feature provider correctly") {
                            expect(sut.featureProvider).to(beAnInstanceOf(FeatureProvider.self))
                        }

                        it("sets the features property correctly") {
                            expect(sut!.features).to(equal(testedFeatures))
                        }
                    }

                    context("when providing no parameters") {
                        beforeEach {
                            sut = Capable()
                        }

                        it("registeres all features") {
                            expect(sut!.features).to(equal(CapableFeature.allCases))
                        }
                    }

                    context("after initialization") {
                        var featureProviderMock: FeatureProviderMock!

                        beforeEach {
                            featureProviderMock = FeatureProviderMock()
                            sut = Capable(withFeatures: CapableFeature.allCases, featureProvider: featureProviderMock)
                        }

                        context("when calling statusMap") {
                            let testStatusMap = ["foo": "bar"]
                            
                            beforeEach {
                                featureProviderMock.statusMap = testStatusMap
                                _ = sut.statusMap
                            }

                            it("requests the status map from the statuses module") {
                                expect(sut.statusMap).to(equal(testStatusMap))
                            }
                        }

                        context("when calling isFeatureEnabled") {
                            let testFeature = CapableFeature.voiceOver
                            
                            beforeEach {
                                _ = sut.isFeatureEnabled(feature: testFeature)
                            }

                            it("requests the feature status from the feature provider") {
                                expect(featureProviderMock!.didCallIsFeatureEnabled).to(beTrue())
                                expect(featureProviderMock!.requestedFeature).to(equal(testFeature))
                            }
                        }
                    }
                }
            }
        }
    }

#endif
