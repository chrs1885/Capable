//
//  FontProps.swift
//  Capable
//
//  Created by Christoph Wendt on 20.11.18.
//

import CoreGraphics

struct FontProps: Equatable {
    var fontSize: CGFloat
    var isBoldFont: Bool

    var isLargeText: Bool {
        return fontSize >= 18.0 || (fontSize >= 14.0 && isBoldFont)
    }
}
