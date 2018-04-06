//
//  UIFont+ScaledFont.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

import Foundation

extension UIFont {
    public class func scaledFont(for font: UIFont) -> UIFont {
        let fontMetrics = FontMetrics()
        return fontMetrics.scaledFont(for: font)
    }
    
    public class func scaledFont(name fontName: String, size fontSize: CGFloat) -> UIFont? {
        if let font = UIFont(name: fontName, size: fontSize) {
            let fontMetrics = FontMetrics()
            return fontMetrics.scaledFont(for: font)
        }
        return nil
    }
    
    public class func scaledSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont.systemFont(ofSize: fontSize)
        return UIFont.scaledFont(for: font)
    }
    
    public class func scaledBoldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        return UIFont.scaledFont(for: font)
    }
    
    public class func scaledItalicSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont.italicSystemFont(ofSize: fontSize)
        return UIFont.scaledFont(for: font)
    }
}
