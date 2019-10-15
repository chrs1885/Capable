//
//  FontMetricsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit

    protocol FontMetricsProtocol {
        func scaledFont(for: UIFont) -> UIFont
    }

    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    extension UIFontMetrics: FontMetricsProtocol {}

#endif
