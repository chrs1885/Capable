//
//  UIFont+fontProps.swift
//  Capable
//
//  Created by Christoph Wendt on 23.12.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit

    extension UIFont {
        var fontProps: FontProps {
            return FontProps(fontSize: pointSize, isBoldFont: isBold)
        }

        var isBold: Bool {
            return (fontDescriptor.symbolicTraits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0
        }
    }

#endif
