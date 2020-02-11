//
//  ImageAreaTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 29.09.19.
//

@testable import Capable
import Nimble
import Quick

class ImageAreaTests: QuickSpec {
    override func spec() {
        describe("The ImageArea class") {
            var sut: ImageArea!
            let testImage = ImageType.mock(withColor: .white, rect: CGRect(x: 0, y: 0, width: 3, height: 3))

            context("calling rect()") {
                var actualRect: CGRect!

                context("with .custom") {
                    let testRect = CGRect(x: 1, y: 2, width: 2, height: 1)

                    beforeEach {
                        sut = .custom(rect: testRect)
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        expect(actualRect).to(equal(testRect))
                    }
                }

                context("with .full") {
                    beforeEach {
                        sut = .full
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 0, width: 3, height: 3)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .topLeft") {
                    beforeEach {
                        sut = .topLeft
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 0, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .topCenter") {
                    beforeEach {
                        sut = .topCenter
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 1, y: 0, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .topRight") {
                    beforeEach {
                        sut = .topRight
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 2, y: 0, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .top") {
                    beforeEach {
                        sut = .top
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 0, width: 3, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .centerLeft") {
                    beforeEach {
                        sut = .centerLeft
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 1, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .center") {
                    beforeEach {
                        sut = .center
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 1, y: 1, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .centerRight") {
                    beforeEach {
                        sut = .centerRight
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 2, y: 1, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .horizontalCenter") {
                    beforeEach {
                        sut = .horizontalCenter
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 1, width: 3, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .bottomLeft") {
                    beforeEach {
                        sut = .bottomLeft
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 2, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .bottomCenter") {
                    beforeEach {
                        sut = .bottomCenter
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 1, y: 2, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .bottomRight") {
                    beforeEach {
                        sut = .bottomRight
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 2, y: 2, width: 1, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .bottom") {
                    beforeEach {
                        sut = .bottom
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 2, width: 3, height: 1)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .left") {
                    beforeEach {
                        sut = .left
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 0, y: 0, width: 1, height: 3)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .verticalCenter") {
                    beforeEach {
                        sut = .verticalCenter
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 1, y: 0, width: 1, height: 3)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }

                context("with .right") {
                    beforeEach {
                        sut = .right
                        actualRect = sut.rect(forImage: testImage)
                    }

                    it("return the correct rect") {
                        let expectedRect = CGRect(x: 2, y: 0, width: 1, height: 3)

                        expect(actualRect).to(equal(expectedRect))
                    }
                }
            }
        }
    }
}
