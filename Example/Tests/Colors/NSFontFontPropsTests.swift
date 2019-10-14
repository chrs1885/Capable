//
//  NSFontFontPropsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.12.18.
//

#if os(OSX)

import Quick
import Nimble
@testable import Capable

class NSFontFontPropsTests: QuickSpec {
    override func spec() {
        describe("The NSFont class") {
            var sut: FontProps?

            context("when initialized with a regular font") {
                var testFont: NSFont?

                beforeEach {
                    testFont = NSFont.systemFont(ofSize: 23.0)
                }

                context("when calling fontProps") {
                    beforeEach {
                        sut = testFont!.fontProps
                    }

                    it("returns a fontProps instance that holds the correct font size") {
                        expect(sut!.fontSize).to(equal(testFont?.pointSize))
                    }

                    it("returns a fontProps instance that has the isBoldFont property set to false") {
                        expect(sut!.isBoldFont).to(beFalse())
                    }
                }
            }

            context("when initialized with a bold font") {
                var testFont: NSFont?

                beforeEach {
                    testFont = NSFont.boldSystemFont(ofSize: 23.0)
                }

                context("when calling fontProps") {
                    beforeEach {
                        sut = testFont!.fontProps
                    }

                    it("returns a fontProps instance that has the isBoldFont property set to true") {
                        expect(sut!.isBoldFont).to(beTrue())
                    }
                }
            }
        }
    }
}

#endif
