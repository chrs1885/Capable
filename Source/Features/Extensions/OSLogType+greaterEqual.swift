//
//  OSLogType+greaterEqual.swift
//  Capable
//
//  Created by Christoph Wendt on 08.11.18.
//

import os.log

infix operator >=: ComparisonPrecedence

extension OSLogType {
    static func >= (lhs: OSLogType, rhs: OSLogType) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
}
