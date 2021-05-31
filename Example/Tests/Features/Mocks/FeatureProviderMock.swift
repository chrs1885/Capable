//
//  FeatureProviderMock.swift
//  Example
//
//  Created by Christoph Wendt on 03.05.21.
//  Copyright © 2021 Christoph Wendt. All rights reserved.
//

@testable import Capable
import Foundation

class FeatureProviderMock: FeatureProviderProtocol {
    var didCallFeature = false
    var expectedFeature: FeatureProtocol?

    func feature(featureName _: String) -> FeatureProtocol? {
        didCallFeature = true

        return expectedFeature
    }
}
