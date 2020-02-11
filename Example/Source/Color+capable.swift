//
//  Color+capableGreen.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 24.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

#if os(iOS)

    import UIKit
    typealias TypeColor = UIColor

#elseif os(OSX)

    import AppKit
    typealias TypeColor = NSColor

#endif

extension TypeColor {
    static var capableGreen: TypeColor {
        return TypeColor(red: 137 / 255.0, green: 176 / 255.0, blue: 106 / 255.0, alpha: 1.0)
    }

    static var capableRed: TypeColor {
        return TypeColor(red: 1.0, green: 120 / 255.0, blue: 120 / 255.0, alpha: 1.0)
    }
}
