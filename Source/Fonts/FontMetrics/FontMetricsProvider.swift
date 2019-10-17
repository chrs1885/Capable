//
//  FontMetricsProvider.swift
//  Capable
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit

    struct FontMetricsProvider: FontMetricsProviderProtocol {
        var osVersionProvider: OsVersionProviderProtocol

        init(osVersionProvider: OsVersionProviderProtocol = OsVersionProvider()) {
            self.osVersionProvider = osVersionProvider
        }

        var fontMetrics: FontMetricsProtocol {
            if osVersionProvider.isOsVersionWithUIFontMetrics(), #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
                return UIFontMetrics.default
            }

            return FontMetricsSupport()
        }
    }

#endif
