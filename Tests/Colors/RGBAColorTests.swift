//
//  RGBAColorTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 24.11.18.
//

import Quick
import Nimble
@testable import Capable

class RGBAColorTests: QuickSpec {
    override func spec() {
        struct Color {
            static let white = RGBAColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
            static let black = RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            static let green = RGBAColor(red: 22.0, green: 100.0, blue: 59.0, alpha: 1.0)
            static let orange = RGBAColor(red: 200.0, green: 110.0, blue: 59.0, alpha: 1.0)
            static let semiTransparentColor = RGBAColor(red: 0.5 * 255.0, green: 0.0, blue: 255.0, alpha: 0.75)
            static let blendedColor = RGBAColor(red: 0.625 * 255.0, green: 0.25 * 255.0, blue: 255.0, alpha: 1.0)
        }

        describe("The RGBAColor class") {
            context("when calling getContrastRatio") {
                context("by passing in the same color twice") {
                    it("returns the minimum contrast ratio of 1.0") {
                        expect(RGBAColor.getContrastRatio(forColor: Color.white, andColor: Color.white)).to(equal(1.0))
                    }
                }

                context("by passing in white and black") {
                    it("returns the maximum contrast ratio of 21.0") {
                        expect(RGBAColor.getContrastRatio(forColor: Color.white, andColor: Color.black)).to(equal(21.0))
                    }
                }

                context("by passing in grren and orange color") {
                    it("returns a contrast ratio of 1.96") {
                        let actualContrastRatio = RGBAColor.getContrastRatio(forColor: Color.orange, andColor: Color.green)
                        let rounded = floor(actualContrastRatio * 100) / 100

                        expect(rounded).to(equal(1.96))
                    }
                }
            }

            context("when calling getBlendedColor") {
                context("by passing in a semi transparent color and a opaque color") {
                    it("returns the minimum contrast ratio of 1.0") {
                        let actual = Color.semiTransparentColor.blended(withFraction: Color.semiTransparentColor.alpha, of: Color.white)
                        let expected = Color.blendedColor

                        expect(actual).to(equal(expected))
                    }
                }
            }
        }
    }
}
