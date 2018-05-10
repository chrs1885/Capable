//
//  UIContentSizeCategory+stringValue.swift
//  Capable
//
//  Created by Christoph Wendt on 26.03.18.
//

import Foundation

#if os(iOS) || os(tvOS)
extension UIContentSizeCategory {
    var stringValue: String {
        get {
            switch(self){
            case .extraSmall:
                return "XS"
            case .small:
                return "S"
            case .medium:
                return "M"
            case .large:
                return "L"
            case .extraLarge:
                return "XL"
            case .extraExtraLarge:
                return "XXL"
            case .extraExtraExtraLarge:
                return "XXXL"
            case .accessibilityMedium:
                return "Accessibility M"
            case .accessibilityLarge:
                return "Accessibility L"
            case .accessibilityExtraLarge:
                return "Accessibility XL"
            case .accessibilityExtraExtraLarge:
                return "Accessibility XXL"
            case .accessibilityExtraExtraExtraLarge:
                return "Accessibility XXXL"
            default:
                return "Unknown"
            }
        }
    }
}
#endif
