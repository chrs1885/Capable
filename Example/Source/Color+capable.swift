//
//  Color+capableGreen.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 24.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

#if os(iOS)

import UIKit
typealias Color = UIColor

#elseif os(OSX)

import AppKit
typealias Color = NSColor

#endif

extension Color {
    static var capableGreen: Color {
        return Color(red: 137 / 255.0, green: 176 / 255.0, blue: 106 / 255.0, alpha: 1.0)
    }

    static var capableRed: Color {
        return Color(red: 1.0, green: 120 / 255.0, blue: 120 / 255.0, alpha: 1.0)
    }
}
