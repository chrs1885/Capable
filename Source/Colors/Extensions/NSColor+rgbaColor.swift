//
//  NSColor+rgbaColor.swift
//  Capable
//
//  Created by Christoph Wendt on 20.01.19.
//

#if os(OSX)

    import AppKit

    extension NSColor {
        var rgbaColor: RGBAColor? {
            guard let rgbColor = self.usingColorSpace(.sRGB) else {
                Logger.warning("Input color not compatible with sRGB color space.")
                return nil
            }

            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            return RGBAColor(red: red * 255.0, green: green * 255.0, blue: blue * 255.0, alpha: alpha)
        }
    }

#endif
