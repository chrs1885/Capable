//
//  FontMetricsSupportTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS)

import Quick
import Nimble
@testable import Capable

class FontMetricsSupportTests: QuickSpec {
    override func spec() {
        describe("The FontMetricsSupport") {
            var sut: FontMetricsSupport?

            context("after initialization") {
                beforeEach {
                    sut = FontMetricsSupport()
                }

                it("conforms to UIFontMetricsProtocol") {
                    expect(sut!).to(beAKindOf(FontMetricsProtocol.self))
                }

                context("scaling a font") {
                    it("returns a UIFont instance") {
                        let testFont = UIFont.boldSystemFont(ofSize: 99)
                        let scaledFont = sut!.scaledFont(for: testFont)

                        expect(scaledFont).to(beAKindOf(UIFont.self))
                    }
                }
            }
        }
    }
}

#endif
