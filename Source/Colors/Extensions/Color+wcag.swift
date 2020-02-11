//
//  Color+wcag.swift
//  Capable
//
//  Created by Christoph Wendt on 20.11.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit

    /// Typealias used for colors. It maps to UIColor.
    public typealias TypeColor = UIColor

    /// Typealias used for fonts. It maps to UIFont.
    public typealias TypeFont = UIFont

#elseif os(OSX)

    import AppKit

    /// Typealias used for colors. It maps to NSColor.
    public typealias TypeColor = NSColor

    /// Typealias used for fonts. It maps to NSFont.
    public typealias TypeFont = NSFont

#endif

/// Extension that adds functionality for calculating WCAG compliant high contrast colors.
extension TypeColor {
    /**
     Calculates the color ratio for a text color on a background color.

     - Parameters:
         - textColor: The text color.
         - backgroundColor: The background color.

     - Returns: The contrast ratio for a given pair of colors.

     - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.

     - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.
     */
    public class func getContrastRatio(forTextColor textColor: TypeColor, onBackgroundColor backgroundColor: TypeColor) -> CGFloat? {
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

     - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.

     - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.
     */
    public class func getTextColor(onBackgroundColor backgroundColor: TypeColor) -> TypeColor? {
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

     - Returns: The first color that conforms to the conformance level defined or `nil` if non of the colors provided passed.

     - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.

     - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.
     */
    public class func getTextColor(fromColors colors: [TypeColor], withFont font: TypeFont, onBackgroundColor backgroundColor: TypeColor, conformanceLevel: ConformanceLevel = .AA) -> TypeColor? {
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

    #if os(iOS) || os(tvOS) || os(OSX)

        /**
         Returns the text color with the highest contrast (black or white) for a specific area of given background image.

         - Parameters:
         - backgroundImage: The background image.
         - imageArea: The area of the image that is used as the text background. Defaults to .full.

         - Returns: A color that has the highest contrast with the given background image.

         - Note: For the background image, the alpha component is ignored.

         - Warning: This function will also return `nil` if the image is corrupted.
         */
        public class func getTextColor(onBackgroundImage image: TypeImage, imageArea: ImageArea = .full) -> TypeColor? {
            guard let averageImageColor = image.averageColor(imageArea: imageArea) else { return nil }

            return TypeColor.getTextColor(onBackgroundColor: averageImageColor)
        }

        /**
         Calculates the contrast ratio of a given list of text colors and a specific area of given background image. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.

         - Parameters:
         - colors: A list of possible text colors.
         - font: The font used for the text.
         - backgroundImage: The background image that the text should be displayed on.
         - imageArea: The area of the image that is used as the text background. Defaults to .full.
         - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.

         - Returns: The first color that conforms to the conformance level defined or `nil` if non of the colors provided passed.

         - Note: Semi-transparent text colors will be blended with the background color. However, for the background image, the alpha component is ignored.

         - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.
         */
        public class func getTextColor(fromColors colors: [TypeColor], withFont font: TypeFont, onBackgroundImage image: TypeImage, imageArea: ImageArea = .full, conformanceLevel: ConformanceLevel = .AA) -> TypeColor? {
            guard let averageImageColor = image.averageColor(imageArea: imageArea) else { return nil }

            return TypeColor.getTextColor(fromColors: colors, withFont: font, onBackgroundColor: averageImageColor, conformanceLevel: conformanceLevel)
        }

    #endif

    /**
     Returns the background color with the highest contrast (black or white) for a given text color.

     - Parameters:
        - textColor: The textColor color.

     - Returns: A color that has the highest contrast with the given text color.

     - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.

     - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.
     */
    public class func getBackgroundColor(forTextColor textColor: TypeColor) -> TypeColor? {
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

     - Returns: The first color that conforms to the conformance level defined or `nil` if non of the colors provided passed.

     - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.

     - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.
     */
    public class func getBackgroundColor(fromColors colors: [TypeColor], forTextColor textColor: TypeColor, withFont font: TypeFont, conformanceLevel: ConformanceLevel = .AA) -> TypeColor? {
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
}
