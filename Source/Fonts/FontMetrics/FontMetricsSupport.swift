//
//  FontMetricsSupport.swift
//  Capable
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit

    class FontMetricsSupport: FontMetricsProtocol {
        private var scaler: CGFloat {
            return UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
        }

        func scaledFont(for font: UIFont) -> UIFont {
            return font.withSize(scaler * font.pointSize)
        }
    }

#endif
