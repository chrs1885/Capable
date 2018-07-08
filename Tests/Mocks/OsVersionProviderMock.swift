//
//  OsVersionProviderMock.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//
#if os(iOS) || os(tvOS)
import Foundation

class OsVersionProviderMock: OsVersionProviderProtocol {
    var osVersionWithoutUIFontMetrics = false
    
    func isOsVersionWithoutUIFontMetrics() -> Bool {
        return self.osVersionWithoutUIFontMetrics
    }
}
#endif
