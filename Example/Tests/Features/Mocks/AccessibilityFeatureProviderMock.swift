//
//  AccessibilityFeatureProviderMock.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

import Foundation
@testable import Capable

class AccessibilityFeatureProviderMock: AccessibilityFeatureProviderProtocol {
    var didCallAccessibilityFeature = false
    var expectedAccessibilityFeature: AccessibilityFeatureProtocol?
    
    func accessibilityFeature(featureName: String) -> AccessibilityFeatureProtocol? {
        didCallAccessibilityFeature = true
        
        return expectedAccessibilityFeature
    }
}
