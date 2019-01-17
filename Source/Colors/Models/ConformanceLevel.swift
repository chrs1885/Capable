//
//  ConformanceLevel.swift
//  Capable
//
//  Created by Christoph Wendt on 21.11.18.
//

import CoreGraphics

infix operator >=: ComparisonPrecedence

/// An enum specifying all WCAG conformance levels.
public enum ConformanceLevel {

    /// The minimum level of conformance.
    case A

    /// The medium level of conformance including success criterias of level A.
    case AA

    /// The highest level of conformance including success criterias of level A and AA.
    case AAA

    /// Indicates that no level of conformance has been reached.
    case failed
}

extension ConformanceLevel {
    /**
     Initializes a ConformanceLevel based on a given contrast ratio and font information used for the text.

     - Parameters:
         - contrastRatio: The contrast ratio of a text and its background.
         - fontSize: The font size of the text.
         - isBoldFont: Information regarding the font weight.
     */
    public init(contrastRatio: CGFloat, fontSize: CGFloat, isBoldFont: Bool) {
        let fontProps = FontProps(fontSize: fontSize, isBoldFont: isBoldFont)
        self.init(contrastRatio: contrastRatio, fontProps: fontProps)
    }

    init(contrastRatio: CGFloat, fontProps: FontProps) {
        var value = ConformanceLevel.failed

        if fontProps.isLargeText {
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

    static func >= (lhs: ConformanceLevel, rhs: ConformanceLevel) -> Bool {
        switch lhs {
        case .AAA:
            return rhs == .A || rhs == .AA || rhs == .AAA || rhs == .failed
        case .AA:
            return rhs == .A || rhs == .AA || rhs == .failed
        case .A:
            return rhs == .A || rhs == .failed
        case .failed:
            return rhs == .failed
        }
    }
}
