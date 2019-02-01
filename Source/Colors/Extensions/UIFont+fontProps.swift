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
        return FontProps(fontSize: self.pointSize, isBoldFont: self.isBold)
    }

    var isBold: Bool {
        return (self.fontDescriptor.symbolicTraits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0
    }
}

#endif
