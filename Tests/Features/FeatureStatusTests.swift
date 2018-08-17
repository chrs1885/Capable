//
//  FeatureStatusTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 17.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import Quick
import Nimble
@testable import Capable

class FeatureStatusTests: QuickSpec {
    override func spec() {
        describe("The FeatureStatus class") {
            context("after initialization") {
                var sut: FeatureStatus?
                var testFeature: CapableFeature?
                var testStatusString: String?

                beforeEach {
                    testFeature = .reduceMotion
                    testStatusString = "SomeTestStatus"
                    sut = FeatureStatus(with: testFeature!, statusString: testStatusString!)
                }

                it("sets all properties correctly") {
                    expect(sut!.feature).to(equal(testFeature))
                    expect(sut!.statusString).to(equal(testStatusString))
                }
            }
        }
    }
}

#endif
