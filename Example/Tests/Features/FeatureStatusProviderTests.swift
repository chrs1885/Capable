//
//  FeatureStatusProviderTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 06.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable
    import Nimble
    import Quick

    class FeatureStatusProviderTests: QuickSpec {
        override func spec() {
            describe("The FeatureStatusProvider class") {
                var sut: FeatureStatusProvider!

                context("after initialization with features") {
                    var featureProviderMock: FeatureProviderMock!
                    let testFeature = FeatureMock()

                    beforeEach {
                        featureProviderMock = FeatureProviderMock()
                        featureProviderMock.expectedFeature = testFeature
                        sut = FeatureStatusProvider(features: [.voiceOver], featureProvider: featureProviderMock)
                    }

                    context("calling statusMap") {
                        it("retuns a dictionary containing the status of each feature") {
                            let statusMap = sut.statusMap
                            expect(statusMap).to(haveCount(1))
                            expect(statusMap.first?.key).to(equal(type(of: testFeature).name))
                            expect(statusMap.first?.value).to(equal(testFeature.status))
                        }
                    }

                    context("calling isFeatureEnabled") {
                        beforeEach {
                            _ = sut.isFeatureEnabled(feature: .voiceOver)
                        }

                        it("requests the current feature status from the feature provider") {
                            expect(testFeature.didCallIsEnabled).to(beTrue())
                        }
                    }
                }
            }
        }
    }

#endif
