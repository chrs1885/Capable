//
//  NSFont+fontProps.swift
//  Capable
//
//  Created by Christoph Wendt on 23.12.18.
//

#if os(OSX)

import AppKit

extension NSFont {
    var fontProps: FontProps {
        return FontProps(fontSize: self.pointSize, isBoldFont: self.isBold)
    }

    var isBold: Bool {
        return (self.fontDescriptor.symbolicTraits.rawValue & NSFontSymbolicTraits(NSFontBoldTrait)) != 0
    }
}

#endif
