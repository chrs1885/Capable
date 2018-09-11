//
//  HandicapRowController.swift
//  Example-watchOS Extension
//
//  Created by Christoph Wendt on 20.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import WatchKit

class HandicapRowController: NSObject {
    @IBOutlet var textLabel: WKInterfaceLabel!
    @IBOutlet var subtitleTextLabel: WKInterfaceLabel!
    @IBOutlet var detailTextLabel: WKInterfaceLabel!

    var handicapInfo: (name: String, status: String, featuresText: String)? {
        didSet {
            guard let handicap = handicapInfo else { return }
            textLabel.setText(handicap.name)
            subtitleTextLabel.setText(handicap.featuresText)
            detailTextLabel.setText(handicap.status)
        }
    }
}
