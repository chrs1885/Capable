//
//  CapablePerfTests.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 16.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

import XCTest
import Capable

class CapablePerfTests: XCTestCase {
    var sut: Capable?

    override func setUp() {
        super.setUp()
        sut = Capable(withFeatures: CapableFeature.allCases)
    }

    func testStatusMapPerformance() {
        measure {
            _ = sut!.statusMap
        }
    }
}

#endif
