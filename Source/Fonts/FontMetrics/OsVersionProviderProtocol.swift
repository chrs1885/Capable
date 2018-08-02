//
//  OsVersionProviderProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import Foundation

protocol OsVersionProviderProtocol {
    func isOsVersionWithoutUIFontMetrics() -> Bool
}

#endif
