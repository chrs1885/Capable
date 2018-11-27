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
        let luminance1 = aColor.relativeLuminance
        let luminance2 = otherColor.relativeLuminance

        return (max(luminance1, luminance2) + 0.05) / (min(luminance1, luminance2) + 0.05)
    }

    static func getBlendedColor(forColor aColor: RGBAColor, andColor otherColor: RGBAColor) -> RGBAColor {
        func blendColorComponent(aColorComponent: CGFloat, transparency: CGFloat, otherColorComponent: CGFloat) -> CGFloat {
            let blendedComponent = transparency * aColorComponent + (1 - transparency) * otherColorComponent
            return blendedComponent
        }

        let red = blendColorComponent(aColorComponent: aColor.red, transparency: aColor.alpha, otherColorComponent: otherColor.red)
        let green = blendColorComponent(aColorComponent: aColor.green, transparency: aColor.alpha, otherColorComponent: otherColor.green)
        let blue = blendColorComponent(aColorComponent: aColor.blue, transparency: aColor.alpha, otherColorComponent: otherColor.blue)

        return RGBAColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    var relativeLuminance: CGFloat {
        func adjustedColorComponent(_ colorComponent: CGFloat) -> CGFloat {
            if colorComponent <= 0.03928 {
                return (colorComponent / 255.0) / 12.92
            } else {
                return pow((colorComponent/255.0 + 0.055) / 1.055, 2.4)
            }
        }

        let adjustedRed = adjustedColorComponent(self.red)
        let adjustedGreen = adjustedColorComponent(self.green)
        let adjustedBlue = adjustedColorComponent(self.blue)

        return (0.2126 * adjustedRed) + (0.7152 * adjustedGreen) + (0.0722 * adjustedBlue)
    }
}
