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
        struct FontSize {
            static let large: CGFloat = 18.0
            static let small: CGFloat = 14.0
        }

        describe("The ConformanceLevel class") {
            var sut: ConformanceLevel?
            context("when initialized") {
                context("with a contrast ratio of 2.9") {
                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 2.9, fontSize: FontSize.large)
                        }

                        it("returns .failed") {
                            expect(sut!).to(equal(.failed))
                        }
                    }
                }

                context("with a contrast ratio of 3.0") {
                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 3.0, fontSize: FontSize.large)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }
                }

                context("with a contrast ratio of 4.4") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.4, fontSize: FontSize.small)
                        }

                        it("returns .failed") {
                            expect(sut!).to(equal(.failed))
                        }
                    }

                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.4, fontSize: FontSize.large)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }
                }

                context("with a contrast ratio of 4.5") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.5, fontSize: FontSize.small)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }

                    context("and large text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 4.5, fontSize: FontSize.large)
                        }

                        it("returns .AAA") {
                            expect(sut!).to(equal(.AAA))
                        }
                    }
                }

                context("with a contrast ratio of 6.9") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 6.9, fontSize: FontSize.small)
                        }

                        it("returns .AA") {
                            expect(sut!).to(equal(.AA))
                        }
                    }
                }

                context("with a contrast ratio of 7.0") {
                    context("and small text size") {
                        beforeEach {
                            sut = ConformanceLevel(contrastRatio: 7.0, fontSize: FontSize.small)
                        }

                        it("returns .AAA") {
                            expect(sut!).to(equal(.AAA))
                        }
                    }
                }
            }

            context("when calling isLargeText") {
                context("with a fontSize of 17.9") {
                    it("returns false") {
                        expect(ConformanceLevel.isLargeText(fontSize: FontSize.large-0.1)).to(beFalse())
                    }
                }

                context("with a fontSize of 18.0") {
                    it("returns true") {
                        expect(ConformanceLevel.isLargeText(fontSize: FontSize.large)).to(beTrue())
                    }
                }

                context("with a fontSize of 13.9 and isBoldFont set to true") {
                    it("returns false") {
                        expect(ConformanceLevel.isLargeText(fontSize: FontSize.small-0.1, isBoldFont: true)).to(beFalse())
                    }
                }

                context("with a fontSize of 14.0 and isBoldFont set to true") {
                    it("returns true") {
                        expect(ConformanceLevel.isLargeText(fontSize: FontSize.small, isBoldFont: true)).to(beTrue())
                    }
                }
            }
        }
    }
}
