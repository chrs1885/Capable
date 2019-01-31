//
//  UIColor+rgbaColor.swift
//  Capable
//
//  Created by Christoph Wendt on 20.01.19.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import UIKit

extension UIColor {
    var rgbaColor: RGBAColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, white: CGFloat = 0, alpha: CGFloat = 0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return RGBAColor(red: (red * 255.0), green: (green * 255.0), blue: (blue * 255.0), alpha: alpha)
        } else if self.getWhite(&white, alpha: &alpha) {
            let white = white * 255.0
            return RGBAColor(red: white, green: white, blue: white, alpha: alpha)
        } else {
            Logger.warning("Input color not compatible with sRGB color space.")
            return nil
        }
    }
}

#endif
