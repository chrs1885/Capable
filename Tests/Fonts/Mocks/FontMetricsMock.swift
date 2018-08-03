//
//  FontMetricsMock.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS)

import UIKit

@testable import Capable

class FontMetricsMock: FontMetricsProtocol {
    var didCallScaledFont: Bool = false
    var scaledFont: UIFont?

    func scaledFont(for font: UIFont) -> UIFont {
        didCallScaledFont = true
        scaledFont = font
        return font
    }
}

#endif
