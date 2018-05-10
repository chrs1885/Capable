//
//  FontMetricsMock.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

import Foundation

class FontMetricsMock: FontMetrics {
    var scaledFontPriorIOS11Called = false
    var scaledFontSinceIOS11Called = false
    
    override func scaledFontPriorIOS11(for font: UIFont) -> UIFont {
        scaledFontPriorIOS11Called = true
        return font
    }
    
    override func scaledFontSinceIOS11(for font: UIFont) -> UIFont {
        scaledFontSinceIOS11Called = true
        return font
    }
}
