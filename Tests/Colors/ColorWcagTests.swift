//
//  ColorWcagTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 14.01.19.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import UIKit
public typealias Color = UIColor
public typealias Font = UIFont

struct Colors {
    static let white = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
    static let black = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let colorWithContrastRatio3 = UIColor(red: 148.0, green: 148.0, blue: 148.0, alpha: 1.0)
    static let colorWithContrastRatio4_5 = UIColor(red: 118.0, green: 118.0, blue: 118.0, alpha: 1.0)
    static let colorWithContrastRatio7 = UIColor(red: 89.0, green: 89.0, blue: 89.0, alpha: 1.0)
    static let semiTransparentColor = UIColor(red: 127.5, green: 0.0, blue: 255.0, alpha: 0.75)
    static let grayscaleColor = UIColor.white
    static let p3Color = UIColor(displayP3Red: 310.0, green: -255.0, blue: 127.5, alpha: 1.0)
}

#elseif os(OSX)

import AppKit
public typealias Color = NSColor
public typealias Font = NSFont

struct Colors {
    static let white = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let black = NSColor(deviceRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let colorWithContrastRatio3 = NSColor(deviceRed: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1.0)
    static let colorWithContrastRatio4_5 = NSColor(deviceRed: 118/255.0, green: 118/255.0, blue: 118/255.0, alpha: 1.0)
    static let colorWithContrastRatio7 = NSColor(deviceRed: 89/255.0, green: 89/255.0, blue: 89/255.0, alpha: 1.0)
    static let semiTransparentColor = NSColor(deviceRed: 0.5, green: 0.0, blue: 1.0, alpha: 0.75)
    static let grayscaleColor = NSColor.white
    static let cmykColor = NSColor(deviceCyan: 1.0, magenta: 0.0, yellow: 0.0, black: 0.0, alpha: 1.0)
    static let p3Color = NSColor(displayP3Red: 2.0, green: -1.0, blue: 0.5, alpha: 1.0)
}

#endif

import Quick
import Nimble
@testable import Capable

class ColorWcagTests: QuickSpec {
    override func spec() {
        struct Fonts {
            static let smallFont = Font.systemFont(ofSize: 14.0)
            static let smallBoldFont = Font.boldSystemFont(ofSize: 14.0)
            static let largeFont = Font.systemFont(ofSize: 18.0)
        }

        describe("The NSColor class") {
            context("when calling rgbaColor") {
                context("when color space is sRGB") {
                    it("normalizes components to be between 0.0 and 255.0") {
                        let color = Colors.white.rgbaColor!

                        expect(color.red).to(equal(255.0))
                        expect(color.green).to(equal(255.0))
                        expect(color.blue).to(equal(255.0))
                        expect(color.alpha).to(equal(1.0))
                    }
                }

                context("when color space is P3") {
                    it("normalizes components to sRGB") {
                        let color = Colors.p3Color.rgbaColor!

                        expect(color.red).to(equal(255.0))
                        expect(color.green).to(equal(0.0))
                        expect(floor(color.blue)).to(equal(127.0))
                        expect(color.alpha).to(equal(1.0))
                    }
                }

                context("when color space is Grayscale") {
                    it("uses white value for each color component") {
                        let color = Colors.grayscaleColor.rgbaColor!

                        #if os(iOS) || os(tvOS) || os(watchOS)

                        var whiteComponent: CGFloat = 0, alphaComponent: CGFloat = 0
                        Colors.grayscaleColor.getWhite(&whiteComponent, alpha: &alphaComponent)

                        #elseif os(OSX)

                        let whiteComponent = Colors.grayscaleColor.whiteComponent*255.0
                        let alphaComponent = Colors.grayscaleColor.alphaComponent

                        #endif

                        expect(color.red).to(equal(whiteComponent))
                        expect(color.green).to(equal(whiteComponent))
                        expect(color.blue).to(equal(whiteComponent))
                        expect(color.alpha).to(equal(alphaComponent))
                    }
                }

                #if os(OSX)

                context("when color space is CMYK compatible") {
                    it("converts the color to sRGB") {
                        expect(Colors.cmykColor.rgbaColor).toNot(throwError())
                    }
                }

                #endif
            }

            context("when calling getContrastRatio") {
                context("by passing in the same color twice") {
                    it("returns the minimum contrast ratio of 1.0") {
                        expect(Color.getContrastRatio(forTextColor: Colors.white, onBackgroundColor: Colors.white)).to(equal(1.0))
                    }
                }

                context("by passing in white and black") {
                    it("returns the maximum contrast ratio of 21.0") {
                        expect(Color.getContrastRatio(forTextColor: Colors.white, onBackgroundColor: Colors.black)).to(equal(21.0))
                    }
                }

                context("by passing in green and orange color") {
                    it("returns a contrast ratio of 2.31") {
                        let actualContrastRatio = Color.getContrastRatio(forTextColor: Colors.colorWithContrastRatio3, onBackgroundColor: Colors.colorWithContrastRatio7)!
                        let rounded = floor(actualContrastRatio * 100) / 100

                        expect(rounded).to(equal(2.3))
                    }
                }

                context("by passing in semi transparent color and white") {
                    it("returns a contrast ratio of 4.51") {
                        let actualContrastRatio = Color.getContrastRatio(forTextColor: Colors.semiTransparentColor, onBackgroundColor: Colors.white)!
                        let rounded = floor(actualContrastRatio * 100) / 100

                        expect(rounded).to(equal(4.51))
                    }
                }
            }

            context("when calling getTextColor") {
                context("by passing in a dark background color") {
                    it("returns white") {
                        let actual = Color.getTextColor(onBackgroundColor: Colors.black)

                        expect(actual).to(equal(Color.white))
                    }
                }

                context("by passing in a light background color") {
                    it("returns black") {
                        let actual = Color.getTextColor(onBackgroundColor: Colors.white)

                        expect(actual).to(equal(Color.black))
                    }
                }

                context("by passing in a background color with a medium relative luminance") {
                    it("returns black") {
                        let actual = Color.getTextColor(onBackgroundColor: Colors.colorWithContrastRatio4_5)

                        expect(actual).to(equal(Color.black))
                    }
                }
            }

            context("when calling getTextColor with a list of colors") {
                var colors: [Color]?

                beforeEach {
                    colors = [
                        Colors.colorWithContrastRatio3,
                        Colors.colorWithContrastRatio4_5,
                        Colors.colorWithContrastRatio7
                    ]
                }

                context("by not providing any passing color") {
                    it("returns nil") {
                        let actual = Color.getTextColor(fromColors: [], withFont: Fonts.smallFont, onBackgroundColor: Colors.white, conformanceLevel: .AA)

                        expect(actual).to(beNil())
                    }
                }

                context("when defining conformance level .AA") {
                    context("when using a small font") {
                        it("returns black") {
                            let actual = Color.getTextColor(fromColors: colors!, withFont: Fonts.smallFont, onBackgroundColor: Colors.white, conformanceLevel: .AA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio4_5))
                        }
                    }

                    context("when using a small bold font") {
                        it("returns black") {
                            let actual = Color.getTextColor(fromColors: colors!, withFont: Fonts.smallBoldFont, onBackgroundColor: Colors.white, conformanceLevel: .AA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio3))
                        }
                    }

                    context("when using a large font") {
                        it("returns black") {
                            let actual = Color.getTextColor(fromColors: colors!, withFont: Fonts.largeFont, onBackgroundColor: Colors.white, conformanceLevel: .AA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio3))
                        }
                    }
                }

                context("when defining conformance level .AAA") {
                    context("when using a small font") {
                        it("returns black") {
                            let actual = Color.getTextColor(fromColors: colors!, withFont: Fonts.smallFont, onBackgroundColor: Colors.white, conformanceLevel: .AAA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio7))
                        }
                    }

                    context("when using a small bold font") {
                        it("returns black") {
                            let actual = Color.getTextColor(fromColors: colors!, withFont: Fonts.smallBoldFont, onBackgroundColor: Colors.white, conformanceLevel: .AAA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio4_5))
                        }
                    }

                    context("when using a large font") {
                        it("returns black") {
                            let actual = Color.getTextColor(fromColors: colors!, withFont: Fonts.largeFont, onBackgroundColor: Colors.white, conformanceLevel: .AAA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio4_5))
                        }
                    }
                }
            }

            context("when calling getBackgroundColor") {
                context("by passing in a dark text color") {
                    it("returns white") {
                        let actual = Color.getBackgroundColor(forTextColor: Colors.black)

                        expect(actual).to(equal(Color.white))
                    }
                }

                context("by passing in a light text color") {
                    it("returns black") {
                        let actual = Color.getBackgroundColor(forTextColor: Colors.white)

                        expect(actual).to(equal(Color.black))
                    }
                }

                context("by passing in a text color with a medium relative luminance") {
                    it("returns black") {
                        let actual = Color.getBackgroundColor(forTextColor: Colors.colorWithContrastRatio4_5)

                        expect(actual).to(equal(Color.black))
                    }
                }
            }

            context("when calling getBackgroundColor with a list of colors") {
                var colors: [Color]?

                beforeEach {
                    colors = [
                        Colors.colorWithContrastRatio3,
                        Colors.colorWithContrastRatio4_5,
                        Colors.colorWithContrastRatio7
                    ]
                }

                context("by not providing any passing color") {
                    it("returns nil") {
                        let actual = Color.getBackgroundColor(fromColors: [], forTextColor: Colors.white, withFont: Fonts.smallFont, conformanceLevel: .AA)

                        expect(actual).to(beNil())
                    }
                }

                context("when defining conformance level .AA") {
                    context("when using a small font") {
                        it("returns black") {
                            let actual = Color.getBackgroundColor(fromColors: colors!, forTextColor: Colors.white, withFont: Fonts.smallFont, conformanceLevel: .AA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio4_5))
                        }
                    }

                    context("when using a small bold font") {
                        it("returns black") {
                            let actual = Color.getBackgroundColor(fromColors: colors!, forTextColor: Colors.white, withFont: Fonts.smallBoldFont, conformanceLevel: .AA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio3))
                        }
                    }

                    context("when using a large font") {
                        it("returns black") {
                            let actual = Color.getBackgroundColor(fromColors: colors!, forTextColor: Colors.white, withFont: Fonts.largeFont, conformanceLevel: .AA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio3))
                        }
                    }
                }

                context("when defining conformance level .AAA") {
                    context("when using a small font") {
                        it("returns black") {
                            let actual = Color.getBackgroundColor(fromColors: colors!, forTextColor: Colors.white, withFont: Fonts.smallFont, conformanceLevel: .AAA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio7))
                        }
                    }

                    context("when using a small bold font") {
                        it("returns black") {
                            let actual = Color.getBackgroundColor(fromColors: colors!, forTextColor: Colors.white, withFont: Fonts.smallBoldFont, conformanceLevel: .AAA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio4_5))
                        }
                    }

                    context("when using a large font") {
                        it("returns black") {
                            let actual = Color.getBackgroundColor(fromColors: colors!, forTextColor: Colors.white, withFont: Fonts.largeFont, conformanceLevel: .AAA)

                            expect(actual).to(equal(Colors.colorWithContrastRatio4_5))
                        }
                    }
                }
            }
        }
    }
}
