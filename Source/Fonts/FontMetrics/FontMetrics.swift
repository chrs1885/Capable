//
//  FontMetrics.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

import Foundation

class FontMetrics: FontMetricsProtocol {
    
    var osVersionProvider: OsVersionProviderProtocol

    init() {
        self.osVersionProvider = OsVersionProvider()
    }
    
    var scaler: CGFloat {
        get {
            return UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
        }
    }
    
    func scaledFont(for font: UIFont) -> UIFont {
        if(self.osVersionProvider.isOsVersionPrior11()) {
            return self.scaledFontPriorIOS11(for: font)
        } else {
            return self.scaledFontSinceIOS11(for: font)
        }
    }
    
    func scaledFontPriorIOS11(for font: UIFont) -> UIFont {
        let scaledFontSize = font.pointSize * self.scaler
        return font.withSize(scaledFontSize)
    }
    
    func scaledFontSinceIOS11(for font: UIFont) -> UIFont {
        if #available(iOS 11.0, *) {
            let fontMetrics = UIFontMetrics.default
            return fontMetrics.scaledFont(for: font)
        }
        fatalError()
    }
}
