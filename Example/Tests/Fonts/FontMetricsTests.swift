//
//  FontMetricsTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS)

    @testable import Capable
    import Nimble
    import Quick

    class FontMetricsTests: QuickSpec {
        override func spec() {
            describe("The FontMetrics") {
                var testFont: UIFont?
                var sut: FontMetrics?
                var fontMetricsMock: FontMetricsMock?

                beforeEach {
                    fontMetricsMock = FontMetricsMock()
                    testFont = UIFont.boldSystemFont(ofSize: 99)

                    let fontMetricsProviderMock = FontMetricsProviderMock(fontMetrics: fontMetricsMock!)
                    sut = FontMetrics(fontMetricsProvider: fontMetricsProviderMock)
                }

                context("after initialization") {
                    it("has the fontMetrics instance from the provider") {
                        expect(sut!.fontMetrics as? FontMetricsMock).to(beIdenticalTo(fontMetricsMock!))
                    }

                    context("calling scaledFont:for") {
                        it("calls scaledFont:for on its fontMetrics object") {
                            _ = sut!.scaledFont(for: testFont!)
                            expect(fontMetricsMock!.didCallScaledFont).to(beTrue())
                        }

                        it("calls scaledFont:for with the passed font") {
                            _ = sut!.scaledFont(for: testFont!)
                            expect(fontMetricsMock!.scaledFont!).to(equal(testFont!))
                        }
                    }
                }
            }
        }
    }

#endif
