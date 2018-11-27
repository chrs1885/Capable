//
//  ConformanceLevel.swift
//  Capable
//
//  Created by Christoph Wendt on 21.11.18.
//

import CoreGraphics

/// An enum specifying all WCAG conformance levels.
public enum ConformanceLevel {

    /// The minimum level of conformance.
    case A

    /// The medium level of conformance including success criterias of level A.
    case AA

    /// The highest level of conformance including success criterias of level A and AA.
    case AAA

    ///  Indicates that no level of conformance has been reached.
    case failed
}

extension ConformanceLevel {

    /**
     Initializes the WCAG level of text for a given contrast ratio, font size, and font weight.

     - Parameters:
     - contrastRatio: The contrast ratio calculated by the text color and its background color.
     - fontSize: The font size of the text.
     - isBoldFont: A flag indicating whether the font weight of the text is bold or not. This is set to `false` by default.
     */
    init(contrastRatio: CGFloat, fontSize: CGFloat, isBoldFont: Bool = false) {
        var value = ConformanceLevel.failed
        let isLargeText = ConformanceLevel.isLargeText(fontSize: fontSize, isBoldFont: isBoldFont)

        if isLargeText {
            if contrastRatio >= 4.5 {
                value = .AAA
            } else if contrastRatio >= 3.0 {
                value = .AA
            }
        } else {
            if contrastRatio >= 7.0 {
                value = .AAA
            } else if contrastRatio >= 4.5 {
                value = .AA
            }
        }

        self = value
    }

    static func isLargeText(fontSize: CGFloat, isBoldFont: Bool = false) -> Bool {
        return fontSize >= 18.0 || fontSize >= 14 && isBoldFont
    }
}
