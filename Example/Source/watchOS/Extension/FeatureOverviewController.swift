//
//  FeatureOverviewController.swift
//  Example-watchOS Extension
//
//  Created by Christoph Wendt on 10.05.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import WatchKit
import Foundation
import Capable

class FeatureOverviewController: WKInterfaceController {
    var objects: [CapableFeature: String]?
    var capable: Capable?
    @IBOutlet var featuresTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.capable = Capable()
        refreshData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.featureStatusChanged),
            name: .CapableFeatureStatusDidChange,
            object: nil)
        if let objects = self.objects {
            self.featuresTable.setNumberOfRows(objects.count, withRowType: "FeatureRow")
            for index in 0..<featuresTable.numberOfRows {
                guard let controller = featuresTable.rowController(at: index) as? FeatureRowController else { continue }
                let item = self.value(forRow: index)
                controller.feature = item
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func refreshData() {
        if let capable = self.capable {
            self.objects = capable.statusMap
        }
    }
    
    func value(forRow row: Int) -> (key: CapableFeature, value: String) {
        if let objects = self.objects {
            let featuresArray = Array(objects)
            return featuresArray[row]
        }
        fatalError("Requested item does not exist")
    }
}

// MARK: Capable Notification
extension FeatureOverviewController {
    @objc private func featureStatusChanged(notification: NSNotification) {
        
    }
}
