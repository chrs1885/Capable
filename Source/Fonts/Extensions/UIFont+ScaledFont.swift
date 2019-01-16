//
//  UIFont+ScaledFont.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import UIKit

/// Extension that adds functionality for creating scalable UIFont objects.
extension UIFont {

    /**
     Makes the given font scalable.

     - Parameters:
        - font: The font to make scalable.

     - Returns: A scalable font object.
     */
    public class func scaledFont(for font: UIFont) -> UIFont {
        let fontMetrics = FontMetrics()
        return fontMetrics.scaledFont(for: font)
    }

    /**
     Creates a scalable font with the given font name and reference font size.

     - Parameters:
        - fontName: The name of the font that should be used.
        - fontSize: The reference font size to use.

     - Returns: A scalable font object.
     */
    public class func scaledFont(withName fontName: String, ofSize fontSize: CGFloat) -> UIFont? {
        if let font = UIFont(name: fontName, size: fontSize) {
            let fontMetrics = FontMetrics()
            return fontMetrics.scaledFont(for: font)
        }
        return nil
    }

    /**
     Creates a scalable system font with a given reference font size.

     - Parameters:
     - fontSize: The reference font size to use.

     - Returns: A scalable font object.
     */
    public class func scaledSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont.systemFont(ofSize: fontSize)
        return UIFont.scaledFont(for: font)
    }

    /**
     Creates a scalable bold system font with a given reference font size.

     - Parameters:
     - fontSize: The reference font size to use.

     - Returns: A scalable font object.
     */
    public class func scaledBoldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        return UIFont.scaledFont(for: font)
    }

    /**
     Creates a scalable italic system font with a given reference font size.

     - Parameters:
     - fontSize: The reference font size to use.

     - Returns: A scalable font object.
     */
    public class func scaledItalicSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont.italicSystemFont(ofSize: fontSize)
        return UIFont.scaledFont(for: font)
    }
}

#endif
