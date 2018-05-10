//
//  OsVersionProviderMock.swift
//  Capable
//
//  Created by Christoph Wendt on 30.04.18.
//

import Foundation

class OsVersionProviderMock: OsVersionProviderProtocol {
    var osVersionPrior11 = false
    
    func isOsVersionPrior11() -> Bool {
        return self.osVersionPrior11
    }
}
