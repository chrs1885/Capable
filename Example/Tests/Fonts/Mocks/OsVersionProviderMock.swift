//
//  OsVersionProviderMock.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

#if os(iOS) || os(tvOS)

@testable import Capable

class OsVersionProviderMock: OsVersionProviderProtocol {
    var osVersionWithUIFontMetrics = false

    func isOsVersionWithUIFontMetrics() -> Bool {
        return self.osVersionWithUIFontMetrics
    }
}

#endif
