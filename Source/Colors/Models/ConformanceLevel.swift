//
//  ConformanceLevel.swift
//  Capable
//
//  Created by Christoph Wendt on 21.11.18.
//

import CoreGraphics

infix operator >=: ComparisonPrecedence

/// An enum specifying all WCAG conformance levels.
public enum ConformanceLevel: Int {
    /// The minimum level of conformance.
    case A = 1

    /// The medium level of conformance including success criterias of level A.
    case AA = 2

    /// The highest level of conformance including success criterias of level A and AA.
    case AAA = 3

    /// Indicates that no level of conformance has been reached.
    case failed = 0
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

    /// The text representation of the conformance level.
    public var text: String {
        switch self {
        case .A:
            return "A"
        case .AA:
            return "AA"
        case .AAA:
            return "AAA"
        case .failed:
            return "failed"
        }
    }

    static func >= (lhs: ConformanceLevel, rhs: ConformanceLevel) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
}
