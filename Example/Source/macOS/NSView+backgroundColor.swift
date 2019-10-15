//
//  NSView+backgroundColor.swift
//  Example-macOS
//
//  Created by Christoph Wendt on 27.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import AppKit

extension NSView {
    var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}
