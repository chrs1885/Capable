//
//  UIFontFontPropsTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 03.01.19.
//

#if os(iOS) || os(tvOS)

    @testable import Capable
    import Nimble
    import Quick

    class UIFontFontPropsTests: QuickSpec {
        override func spec() {
            describe("The UIFont class") {
                var sut: FontProps?

                context("when initialized with a regular font") {
                    var testFont: UIFont?

                    beforeEach {
                        testFont = UIFont.systemFont(ofSize: 23.0)
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
                    var testFont: UIFont?

                    beforeEach {
                        testFont = UIFont.boldSystemFont(ofSize: 23.0)
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
