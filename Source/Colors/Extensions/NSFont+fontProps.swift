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
            return FontProps(fontSize: pointSize, isBoldFont: isBold)
        }

        var isBold: Bool {
            return (fontDescriptor.symbolicTraits.rawValue & NSFontSymbolicTraits(NSFontBoldTrait)) != 0
        }
    }

#endif
