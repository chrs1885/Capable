//
//  NSColor+wcag.swift
//  Capable
//
//  Created by Christoph Wendt on 20.11.18.
//

#if os(OSX)

import AppKit

/// Extension that adds functionality for calculating colors that conform to WCAG success criterias.
extension NSColor {

    /**
     Calculates the color ratio for a text color on a background color.

     - Parameters:
         - textColor: The text color.
         - backgroundColor: The background color.

     - Returns: The contrast ratio for a given pair of colors.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getContrastRatio(forTextColor textColor: NSColor, onBackgroundColor backgroundColor: NSColor) -> CGFloat? {
        guard let rgbaTextColor = textColor.rgbaColor, let rgbaBackgroundColor = backgroundColor.rgbaColor else {
            return nil
        }

        return RGBAColor.getContrastRatio(forTextColor: rgbaTextColor, onBackgroundColor: rgbaBackgroundColor)
    }

    /**
     Returns the text color with the highest contrast (black or white) for a given background color.

     - Parameters:
        - backgroundColor: The background color.

     - Returns: A color that has the highest contrast with the given background color.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getTextColor(onBackgroundColor backgroundColor: NSColor) -> NSColor? {
        guard let rgbaBackgroundColor = backgroundColor.rgbaColor else { return nil }
        let textColor = RGBAColor.getTextColor(onBackgroundColor: rgbaBackgroundColor)

        return textColor == RGBAColor.Colors.black ? .black : .white
    }

    /**
     Calculates the contrast ratio of a given list of text colors and a background color. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.

     - Parameters:
         - colors: A list of possible text colors.
         - font: The font used for the text.
         - backgroundColor: The background color that the text should be displayed on.
         - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.

     - Returns: The first color that conforms to the conformance level defined.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getTextColor(fromColors colors: [NSColor] = [], withFont font: NSFont, onBackgroundColor backgroundColor: NSColor, conformanceLevel: ConformanceLevel = .AA) -> NSColor? {
        guard let rgbaBackgroundColor = backgroundColor.rgbaColor else { return nil }

        for textColor in colors {
            guard let rgbaTextColor = textColor.rgbaColor else { return nil }

            let isValidTextColor = RGBAColor.isValidColorCombination(textColor: rgbaTextColor, fontProps: font.fontProps, onBackgroundColor: rgbaBackgroundColor, conformanceLevel: conformanceLevel)
            if isValidTextColor {
                return textColor
            }
        }

        return nil
    }

    /**
     Returns the background color with the highest contrast (black or white) for a given text color.

     - Parameters:
        - textColor: The textColor color.

     - Returns: A color that has the highest contrast with the given text color.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getBackgroundColor(forTextColor textColor: NSColor) -> NSColor? {
        guard let rgbaTextColor = textColor.rgbaColor else { return nil }
        let backgroundColor = RGBAColor.getBackgroundColor(forTextColor: rgbaTextColor)

        return backgroundColor == RGBAColor.Colors.black ? .black : .white
    }

    /**
     Calculates the contrast ratio of a given list of background colors and a text color. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.

     - Parameters:
         - colors: A list of possible background colors.
         - textColor: The text color that should be used.
         - font: The font used for the text.
         - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.

     - Returns: The first color that conforms to the conformance level defined.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getBackgroundColor(fromColors colors: [NSColor], forTextColor textColor: NSColor, withFont font: NSFont, conformanceLevel: ConformanceLevel = .AA) -> NSColor? {
        guard let rgbaTextColor = textColor.rgbaColor else { return nil }

        for backgroundColor in colors {
            guard let rgbaBackgroundColor = backgroundColor.rgbaColor else { return nil }

            let isValidBackgroundColor = RGBAColor.isValidColorCombination(textColor: rgbaTextColor, fontProps: font.fontProps, onBackgroundColor: rgbaBackgroundColor, conformanceLevel: conformanceLevel)
            if isValidBackgroundColor {
                return backgroundColor
            }
        }

        return nil
    }

    var rgbaColor: RGBAColor? {
        guard let rgbColor = self.usingColorSpace(.sRGB) else {
            Logger.warning("Input color not compatible with sRGB color space.")
            return nil
        }

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return RGBAColor(red: (red * 255.0), green: (green * 255.0), blue: (blue * 255.0), alpha: alpha)
    }
}

#endif
