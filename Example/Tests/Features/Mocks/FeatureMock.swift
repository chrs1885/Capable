//
//  FeatureMock.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

@testable import Capable
import Foundation

class FeatureMock: FeatureProtocol {
    var didCallIsEnabled = false
    var didCallStatus = false

    static var name = "FeatureMock"
    var isEnabled: Bool {
        didCallIsEnabled = true
        return true
    }

    var status: String {
        didCallStatus = true
        return "status"
    }
}
