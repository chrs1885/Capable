//
//  Bool+statusString.swift
//  Capable
//
//  Created by Christoph Wendt on 26.03.18.
//

import Foundation

extension Bool {
    var statusString: String {
        return self ? "enabled" : "disabled"
    }
}
