//
//  FontMetrics.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

import Foundation
import UIKit

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
        if(self.osVersionProvider.isOsVersionWithoutUIFontMetrics()) {
            return self.scaledFontWithoutUIFontMetrics(for: font)
        } else {
            return self.scaledFontWithUIFontMetrics(for: font)
        }
    }
    
    func scaledFontWithoutUIFontMetrics(for font: UIFont) -> UIFont {
        let scaledFontSize = font.pointSize * self.scaler
        return font.withSize(scaledFontSize)
    }
    
    func scaledFontWithUIFontMetrics(for font: UIFont) -> UIFont {
        if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            let fontMetrics = UIFontMetrics.default
            return fontMetrics.scaledFont(for: font)
        }
        fatalError()
    }
}
