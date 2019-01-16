//
//  ConformanceLevelTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 24.11.18.
//

import Quick
import Nimble
@testable import Capable

class ConformanceLevelTests: QuickSpec {
    override func spec() {
        struct Font {
            static let large = FontProps(fontSize: 18.0, isBoldFont: false)
            static let smallBold = FontProps(fontSize: 14.0, isBoldFont: true)
            static let small = FontProps(fontSize: 14.0, isBoldFont: false)
        }

        describe("The ConformanceLevel class") {
            var sut: ConformanceLevel?
            context("when initialized") {
                context("with a contrast ratio of 2.9") {
                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 2.9, fontProps: Font.large)
                        }

                        it("returns .failed") {
                            expect(sut!).to(equal(.failed))
                        }
                    }
                }

                context("with a contrast ratio of 3.0") {
                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 3.0, fontProps: Font.large)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }
                }

                context("with a contrast ratio of 4.4") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.4, fontProps: Font.small)
                        }

                        it("returns .failed") {
                            expect(sut!).to(equal(.failed))
                        }
                    }

                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.4, fontProps: Font.large)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }
                }

                context("with a contrast ratio of 4.5") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.5, fontProps: Font.small)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }

                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.5, fontProps: Font.large)
                        }

                        it("returns .AAA") {
                            expect(sut!).to(equal(.AAA))
                        }
                    }
                }

                context("with a contrast ratio of 6.9") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 6.9, fontProps: Font.small)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }
                }

                context("with a contrast ratio of 7.0") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 7.0, fontProps: Font.small)
                        }

                        it("returns .AAA") {
                            expect(sut!).to(equal(.AAA))
                        }
                    }
                }
            }

            context("when comparing ConformanceLevel types by using >= operator") {
                it("returns the correct result") {
                    expect(ConformanceLevel.AAA >= ConformanceLevel.AAA).to(beTrue())
                    expect(ConformanceLevel.AAA >= ConformanceLevel.AA).to(beTrue())
                    expect(ConformanceLevel.AAA >= ConformanceLevel.A).to(beTrue())
                    expect(ConformanceLevel.AAA >= ConformanceLevel.failed).to(beTrue())

                    expect(ConformanceLevel.AA >= ConformanceLevel.AAA).to(beFalse())
                    expect(ConformanceLevel.AA >= ConformanceLevel.AA).to(beTrue())
                    expect(ConformanceLevel.AA >= ConformanceLevel.A).to(beTrue())
                    expect(ConformanceLevel.AA >= ConformanceLevel.failed).to(beTrue())

                    expect(ConformanceLevel.A >= ConformanceLevel.AAA).to(beFalse())
                    expect(ConformanceLevel.A >= ConformanceLevel.AA).to(beFalse())
                    expect(ConformanceLevel.A >= ConformanceLevel.A).to(beTrue())
                    expect(ConformanceLevel.A >= ConformanceLevel.failed).to(beTrue())

                    expect(ConformanceLevel.failed >= ConformanceLevel.AAA).to(beFalse())
                    expect(ConformanceLevel.failed >= ConformanceLevel.AA).to(beFalse())
                    expect(ConformanceLevel.failed >= ConformanceLevel.A).to(beFalse())
                    expect(ConformanceLevel.failed >= ConformanceLevel.failed).to(beTrue())
                }
            }
        }
    }
}
