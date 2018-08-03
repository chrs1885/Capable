//
//  FontMetrics.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import UIKit

class FontMetrics: FontMetricsProtocol {
    var fontMetrics: FontMetricsProtocol

    init(fontMetricsProvider: FontMetricsProviderProtocol = FontMetricsProvider()) {
        self.fontMetrics = fontMetricsProvider.fontMetrics
    }

    func scaledFont(for font: UIFont) -> UIFont {
        return self.fontMetrics.scaledFont(for: font)
    }
}

#endif
