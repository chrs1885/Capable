//
//  HandicapStatusesMock.swift
//  CapableTests
//
//  Created by Christoph Wendt on 05.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable

    class HandicapStatusesMock: HandicapStatusesProtocol {
        var statusMapMock: [String: String] = [:]
        var handicapEnabled: Bool = false
        var didCallStatusMap: Bool = false
        var didCallIsHandicapEnabled: Bool = false

        func isHandicapEnabled(handicapName _: String) -> Bool {
            didCallIsHandicapEnabled = true
            return handicapEnabled
        }

        var statusMap: [String: String] {
            didCallStatusMap = true
            return statusMapMock
        }
    }

#endif
