//
//  RGBAColor.swift
//  Capable
//
//  Created by Christoph Wendt on 20.11.18.
//

import CoreGraphics

struct RGBAColor: Equatable {
    var red, green, blue, alpha: CGFloat

    static func getContrastRatio(forColor aColor: RGBAColor, andColor otherColor: RGBAColor) -> CGFloat {
        var aColor = aColor
        if aColor.alpha < 1.0 {
            aColor = aColor.blended(withFraction: aColor.alpha, of: otherColor)
        }

        let luminance1 = aColor.relativeLuminance
        let luminance2 = otherColor.relativeLuminance

        return (max(luminance1, luminance2) + 0.05) / (min(luminance1, luminance2) + 0.05)
    }

    func blended(withFraction fraction: CGFloat,
                 of color: RGBAColor) -> RGBAColor {
        func getBlendedColorComponent(aColorComponent: CGFloat, fraction: CGFloat, otherColorComponent: CGFloat) -> CGFloat {
            let blendedComponent = fraction * aColorComponent + (1 - fraction) * otherColorComponent
            return blendedComponent
        }

        let red = getBlendedColorComponent(aColorComponent: self.red, fraction: self.alpha, otherColorComponent: color.red)
        let green = getBlendedColorComponent(aColorComponent: self.green, fraction: self.alpha, otherColorComponent: color.green)
        let blue = getBlendedColorComponent(aColorComponent: self.blue, fraction: self.alpha, otherColorComponent: color.blue)

        return RGBAColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    var relativeLuminance: CGFloat {
        func getAdjustedColorComponent(_ colorComponent: CGFloat) -> CGFloat {
            if colorComponent <= 0.03928 {
                return (colorComponent / 255.0) / 12.92
            } else {
                return pow((colorComponent/255.0 + 0.055) / 1.055, 2.4)
            }
        }

        let adjustedRed = getAdjustedColorComponent(self.red)
        let adjustedGreen = getAdjustedColorComponent(self.green)
        let adjustedBlue = getAdjustedColorComponent(self.blue)

        return (0.2126 * adjustedRed) + (0.7152 * adjustedGreen) + (0.0722 * adjustedBlue)
    }
}
