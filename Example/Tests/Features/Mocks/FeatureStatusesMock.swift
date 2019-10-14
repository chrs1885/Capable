//
//  FeatureStatusesMock.swift
//  CapableTests
//
//  Created by Christoph Wendt on 05.10.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable

class FeatureStatusesMock: FeatureStatusesProtocol {
    var statusMapMock: [String: String] = [:]
    var featureEnabled: Bool = false
    var didCallStatusMap: Bool = false
    var didCallIsFeatureEnabled: Bool = false

    func isFeatureEnabled(feature: CapableFeature) -> Bool {
        didCallIsFeatureEnabled = true
        return featureEnabled
    }

    var statusMap: [String: String] {
        didCallStatusMap = true
        return statusMapMock
    }
}

#endif
