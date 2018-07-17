//
//  OsVersionProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

import Foundation

class OsVersionProvider: OsVersionProviderProtocol {
    func isOsVersionWithoutUIFontMetrics() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            return false
        } else {
            return true
        }
    }
}
