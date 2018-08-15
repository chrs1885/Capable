//
//  HandicapTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 15.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class CpableTests: QuickSpec {
    override func spec() {
        describe("The Handicap class") {
            context("after initialization with features") {
                var sut: Handicap?
                var testFeatures: [CapableFeature]?
                var testName: String?
                var testMode: HandicapEnabledMode?

                beforeEach {
                    testName = "TestHandicap"
                    testFeatures = [.reduceMotion, .voiceOver]
                    testMode = .allFeaturesEnabled
                    sut = Handicap(with: testFeatures!, name: testName!, enabledIf: testMode!)
                }

                it("returns a Handicap instance") {
                    expect(sut!).to(beAnInstanceOf(Handicap.self))
                }

                it("sets all properties correctly") {
                    expect(sut!.features).to(equal(testFeatures))
                    expect(sut!.name).to(equal(testName))
                    expect(sut!.enabledIf).to(equal(testMode))
                }
            }
        }
    }
}

#endif
