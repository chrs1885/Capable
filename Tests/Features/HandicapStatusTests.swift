//
//  HandicapStatusTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 17.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class HandicapStatusTests: QuickSpec {
    override func spec() {
        describe("The HandicapStatus class") {
            context("after initialization") {
                var sut: HandicapStatus?
                var testHandicap: Handicap?
                var testStatusString: String?

                beforeEach {
                    testHandicap = Handicap(with: [.reduceMotion], name: "TestHandicap", enabledIf: .oneFeatureEnabled)
                    testStatusString = "SomeTestStatus"
                    sut = HandicapStatus(with: testHandicap!, statusString: testStatusString!)
                }

                it("sets all properties correctly") {
                    expect(sut!.handicap).to(equal(testHandicap!))
                    expect(sut!.statusString).to(equal(testStatusString!))
                }
            }
        }
    }
}

#endif
