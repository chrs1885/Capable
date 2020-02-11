//
//  ImageAverageColorTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 29.09.19.
//

@testable import Capable
import Nimble
import Quick

class ImageAverageColorTests: QuickSpec {
    override func spec() {
        describe("The UIImage/NSImage class") {
            var sut: TypeImage!

            context("when calling averageColor() for a red image") {
                beforeEach {
                    sut = TypeImage.mock(withColor: .red, rect: CGRect(x: 0, y: 0, width: 3, height: 3))
                }

                it("returns .red") {
                    expect(sut.averageColor()?.rgbaColor).to(equal(TypeColor.red.rgbaColor))
                }
            }
        }
    }
}
