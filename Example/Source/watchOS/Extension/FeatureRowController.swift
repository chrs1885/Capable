//
//  FeatureRowController.swift
//  Example-watchOS Extension
//
//  Created by Christoph Wendt on 14.05.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Foundation
import Capable
import WatchKit

class FeatureRowController: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    
    var feature: (key: String, value: String)? {
        didSet {
            guard let feature = feature else { return }
            titleLabel.setText(feature.key)
            statusLabel.setText(feature.value)
        }
    }
}
