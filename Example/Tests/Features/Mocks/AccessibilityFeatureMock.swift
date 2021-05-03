//
//  AccessibilityFeatureMock.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

import Foundation
@testable import Capable

class AccessibilityFeatureMock: AccessibilityFeatureProtocol {
    var didCallIsEnabled = false
    var didCallStatus = false
    
    static var name = "AccessibilityFeatureMock"
    var isEnabled: Bool {
        didCallIsEnabled = true
        return true
    }
    
    var status: String {
        didCallStatus = true
        return "status"
    }
}

