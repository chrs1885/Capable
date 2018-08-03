//
//  OsVersionProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

class OsVersionProvider: OsVersionProviderProtocol {
    func isOsVersionWithUIFontMetrics() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            return true
        } else {
            return false
        }
    }
}

#endif
