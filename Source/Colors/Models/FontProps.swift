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
        return self.fontSize >= 18.0 || (self.fontSize >= 14 && self.isBoldFont)
    }
}
