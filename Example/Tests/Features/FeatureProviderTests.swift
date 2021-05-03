//
//  FeatureProviderTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 06.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable
    import Nimble
    import Quick

    class FeatureProviderTests: QuickSpec {
        override func spec() {
            describe("The FeatureProviderTests class") {
                var sut: FeatureProvider!
                
                context("after initialization with features") {
                    var accessibilityFeatureProviderMock: AccessibilityFeatureProviderMock!
                    let testAccessibilityFeature = AccessibilityFeatureMock()
                    
                    beforeEach {
                        accessibilityFeatureProviderMock = AccessibilityFeatureProviderMock()
                        accessibilityFeatureProviderMock.expectedAccessibilityFeature = testAccessibilityFeature
                        sut = FeatureProvider(features: [.voiceOver], accessibilityFeatureProvider: accessibilityFeatureProviderMock)
                    }
                    
                    context("calling statusMap") {
                        it("retuns a dictionary containing the status of each accessibility feature") {
                            let statusMap = sut.statusMap
                            expect(statusMap).to(haveCount(1))
                            expect(statusMap.first?.key).to(equal(type(of: testAccessibilityFeature).name))
                            expect(statusMap.first?.value).to(equal(testAccessibilityFeature.status))
                        }
                    }
                    
                    context("calling isFeatureEnabled") {
                        beforeEach {
                            _ = sut.isFeatureEnabled(feature: .voiceOver)
                        }
                        
                        it("requests the current feature status from the accessibility feature provider") {
                            expect(testAccessibilityFeature.didCallIsEnabled).to(beTrue())
                        }
                    }
                }
            }
        }
    }

#endif
