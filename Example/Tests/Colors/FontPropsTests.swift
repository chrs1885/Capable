//
//  FontPropsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 15.01.19.
//

import Quick
import Nimble
@testable import Capable

class FontPropsTests: QuickSpec {
    override func spec() {
        describe("The ConformanceLevel class") {
            var sut: FontProps?

            context("when calling isLargeText") {
                context("for font props of a large regular font") {
                    beforeEach {
                        sut = FontProps(fontSize: 18.0, isBoldFont: false)
                    }

                    it("returns true") {
                        expect(sut!.isLargeText).to(beTrue())
                    }
                }

                context("for font props of a small bold font") {
                    beforeEach {
                        sut = FontProps(fontSize: 14.0, isBoldFont: true)
                    }

                    it("returns true") {
                        expect(sut!.isLargeText).to(beTrue())
                    }
                }

                context("for font props of a small regular font") {
                    beforeEach {
                        sut = FontProps(fontSize: 14.0, isBoldFont: false)
                    }

                    it("returns false") {
                        expect(sut!.isLargeText).to(beFalse())
                    }
                }
            }
        }
    }
}
