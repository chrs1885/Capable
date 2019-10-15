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
            func normalize(_ component: CGFloat) -> CGFloat {
                let nomralizedValue = component * 255.0

                if nomralizedValue > 255.0 { return 255.0 }
                if nomralizedValue < 0.0 { return 0.0 }
                return nomralizedValue
            }

            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, white: CGFloat = 0, alpha: CGFloat = 0

            if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                return RGBAColor(red: normalize(red), green: normalize(green), blue: normalize(blue), alpha: alpha)
            } else if getWhite(&white, alpha: &alpha) {
                let white = normalize(white)
                return RGBAColor(red: white, green: white, blue: white, alpha: alpha)
            } else {
                Logger.warning("Input color not compatible with sRGB color space.")
                return nil
            }
        }
    }

#endif
