//
//  FontMetricsMock.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//
#if os(iOS) || os(tvOS)
import Foundation
import UIKit
    
class FontMetricsMock: FontMetrics {
    var scaledFontWithoutUIFontMetricsCalled = false
    var scaledFontWithUIFontMetricsCalled = false
    
    override func scaledFontWithoutUIFontMetrics(for font: UIFont) -> UIFont {
        scaledFontWithoutUIFontMetricsCalled = true
        return font
    }
    
    override func scaledFontWithUIFontMetrics(for font: UIFont) -> UIFont {
        scaledFontWithUIFontMetricsCalled = true
        return font
    }
}
#endif
