//
//  HandicapTableCellView.swift
//  Example-macOS
//
//  Created by Christoph Wendt on 19.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Foundation
import Cocoa

class HandicapTableCellView: NSTableCellView {
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var subtitleTextLabel: NSTextField!
    @IBOutlet weak var detailTextLabel: NSTextField!
}
