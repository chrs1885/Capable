//
//  OsVersionProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

import Foundation

class OsVersionProvider: OsVersionProviderProtocol {
    func isOsVersionPrior11() -> Bool {
        if #available(iOS 11.0, *) {
            return false
        } else {
            return true
        }
    }
}
