//
//  HandicapOverviewController.swift
//  Example-watchOS Extension
//
//  Created by Christoph Wendt on 20.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import WatchKit
import Foundation
import Capable

class HandicapOverviewController: WKInterfaceController {
    @IBOutlet var handicapsTable: WKInterfaceTable!
    var capable: Capable?
    var handicaps: [Handicap]?
    var objects: [String: String]?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let lowVision = Handicap(with: [.boldText, .largerText], name: "Low Vision", enabledIf: .oneFeatureEnabled)
        self.capable = Capable(withHandicaps: [lowVision])
        self.handicaps = [lowVision]
        self.refreshData()
        self.populateTableData()
    }

    override func didAppear() {
        self.registerObservers()
    }

    override func willDisappear() {
        self.unregisterObservers()
    }

    func populateTableData() {
        if let objects = self.objects {
            self.handicapsTable.setNumberOfRows(objects.count, withRowType: "HandicapRow")
            for index in 0..<handicapsTable.numberOfRows {
                guard let controller = handicapsTable.rowController(at: index) as? HandicapRowController else { continue }
                let handicapInfo = self.value(forRow: index)
                let handicap = self.handicap(forName: handicapInfo.key)
                let featuresText = CapableFeature.keys(forFeatures: handicap.features).joined(separator: ", ")
                controller.handicapInfo = (name: handicapInfo.key, status: handicapInfo.value, featuresText: featuresText)
            }
        }
    }

    func refreshData() {
        if let capable = self.capable {
            self.objects = capable.statusMap
        }
    }

    func value(forRow row: Int) -> (key: String, value: String) {
        if let objects = self.objects {
            let handicapsArray = Array(objects)
            return handicapsArray[row]
        }
        fatalError("Requested item does not exist")
    }

    func handicap(forName name: String) -> Handicap {
        for handicap in self.handicaps! {
            if handicap.name == name {
                return handicap
            }
        }
        fatalError("Requested item does not exist")
    }
}

// MARK: Capable Notification
extension HandicapOverviewController {
    @objc private func handicapStatusChanged(notification: NSNotification) {
        if let handicapStatus = notification.object as? HandicapStatus {
            self.refreshData()
            self.showAlert(for: handicapStatus)
        }
    }

    func registerObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.handicapStatusChanged),
            name: .CapableHandicapStatusDidChange,
            object: nil)
    }

    func unregisterObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    func showAlert(for handicapStatus: HandicapStatus) {
        let alertTitle = "Feature status changed"
        let alertMessage = "\(handicapStatus.handicap.name) changed to \(handicapStatus.statusString)"
        let okAction = WKAlertAction(title: "OK",
                                     style: WKAlertActionStyle.default) {}
        presentAlert(withTitle: alertTitle,
                     message: alertMessage,
                     preferredStyle: WKAlertControllerStyle.alert,
                     actions: [okAction])
    }
}
