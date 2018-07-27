//
//  OverviewRowController.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 26.07.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Foundation
import WatchKit

class OverviewRowController: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!

    var title: String? {
        didSet {
            guard let item  = title else { return }
            titleLabel.setText(item)
        }
    }
}
