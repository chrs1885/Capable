//
//  FontsViewController.swift
//  Example-watchOS Extension
//
//  Created by Wendt, Christoph on 27.07.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import WatchKit
import Foundation

class FontsViewController: WKInterfaceController {
    @IBOutlet var fontsTable: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.fontsTable.setNumberOfRows(FontsConstants.fontsList.count, withRowType: "FontRow")
        for index in 0..<fontsTable.numberOfRows {
            guard let controller = fontsTable.rowController(at: index) as? FontRowController else { continue }

            controller.font = FontsConstants.fontsList[index].font
            controller.descriptionText = FontsConstants.fontsList[index].description
        }
    }
}
