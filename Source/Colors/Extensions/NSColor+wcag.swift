//
//  NSColor+wcag.swift
//  Capable
//
//  Created by Christoph Wendt on 20.11.18.
//

#if os(OSX)

import AppKit

/// Extension that adds functionality for calculating WCAG colors.
extension NSColor {

    /**
     Calculates the color ratio of two given colors.

     - Parameters:
     - aColor: The first color.
     - otherColor: The second color.

     - Returns: The contrast ratio for a given pair of colors.
     */
    public class func getContrastRatio(forColor aColor: NSColor, andColor otherColor: NSColor) -> CGFloat {
        guard let color1 = aColor.rgbaColor, let color2 = otherColor.rgbaColor else {
            return 0.0
        }
        return RGBAColor.getContrastRatio(forColor: color1, andColor: color2)
    }

    var rgbaColor: RGBAColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return RGBAColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#endif
