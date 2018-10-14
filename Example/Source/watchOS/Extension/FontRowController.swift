//
//  FontRowController.swift
//  Example-watchOS Extension
//
//  Created by Wendt, Christoph on 27.07.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Foundation
import WatchKit

class FontRowController: NSObject {
    @IBOutlet var fontLabel: WKInterfaceLabel!
    @IBOutlet var descriptionLabel: WKInterfaceLabel!

    var font: UIFont? {
        didSet {
            guard let font = font else { return }
            fontLabel.setAttributedText(NSAttributedString(string: FontsConstants.defaultText, attributes: [NSAttributedString.Key.font: font]))
        }
    }

    var descriptionText: String? {
        didSet {
            guard let description = descriptionText else { return }
            descriptionLabel.setText(description)
        }
    }
}
