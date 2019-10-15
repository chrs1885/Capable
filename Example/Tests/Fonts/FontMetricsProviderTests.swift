//
//  FontMetricsProviderTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS)

    @testable import Capable
    import Nimble
    import Quick

    class FontMetricsProviderTests: QuickSpec {
        override func spec() {
            describe("The FontMetricsProvider") {
                var sut: FontMetricsProvider?

                if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
                    context("when running on device with OS that comes with UIFontMetrics support") {
                        beforeEach {
                            let osVersionProviderMock = OsVersionProviderMock()
                            osVersionProviderMock.osVersionWithUIFontMetrics = true
                            sut = FontMetricsProvider(osVersionProvider: osVersionProviderMock)
                        }

                        it("provides the default UIFontMetrics") {
                            expect(sut!.fontMetrics as? UIFontMetrics).to(beIdenticalTo(UIFontMetrics.default))
                        }
                    }
                }

                context("when running on device with OS without UIFontMetrics support") {
                    beforeEach {
                        let osVersionProviderMock = OsVersionProviderMock()
                        osVersionProviderMock.osVersionWithUIFontMetrics = false
                        sut = FontMetricsProvider(osVersionProvider: osVersionProviderMock)
                    }

                    it("provides an instance of FontMetricsSupport") {
                        expect(sut!.fontMetrics).to(beAnInstanceOf(FontMetricsSupport.self))
                    }
                }
            }
        }
    }

#endif
