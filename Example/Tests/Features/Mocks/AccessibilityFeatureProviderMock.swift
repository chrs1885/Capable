//
//  AccessibilityFeatureProviderMock.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

@testable import Capable
import Foundation

class AccessibilityFeatureProviderMock: AccessibilityFeatureProviderProtocol {
    var didCallAccessibilityFeature = false
    var expectedAccessibilityFeature: AccessibilityFeatureProtocol?

    func accessibilityFeature(featureName _: String) -> AccessibilityFeatureProtocol? {
        didCallAccessibilityFeature = true

        return expectedAccessibilityFeature
    }
}
