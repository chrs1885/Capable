//
//  FeatureOverviewController.swift
//  Example-watchOS Extension
//
//  Created by Christoph Wendt on 10.05.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Capable
import Foundation
import WatchKit

class FeatureOverviewController: WKInterfaceController {
    var objects: [String: String]?
    var capable: Capable?
    @IBOutlet var featuresTable: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        capable = Capable()
        refreshData()
        populateTableData()
    }

    override func didAppear() {
        registerObservers()
    }

    override func willDisappear() {
        unregisterObservers()
    }

    func populateTableData() {
        if let objects = self.objects {
            featuresTable.setNumberOfRows(objects.count, withRowType: "FeatureRow")
            for index in 0 ..< featuresTable.numberOfRows {
                guard let controller = featuresTable.rowController(at: index) as? FeatureRowController else { continue }
                let feature = value(forRow: index)
                controller.feature = feature
            }
        }
    }

    func refreshData() {
        if let capable = self.capable {
            objects = capable.statusMap
        }
    }

    func value(forRow row: Int) -> (key: String, value: String) {
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
        if let featureStatus = notification.object as? FeatureStatus {
            refreshData()
            showAlert(for: featureStatus)
        }
    }

    func registerObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(featureStatusChanged),
            name: .CapableFeatureStatusDidChange,
            object: nil
        )
    }

    func unregisterObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    func showAlert(for featureStatus: FeatureStatus) {
        let alertTitle = "Feature status changed"
        let alertMessage = "\(featureStatus.feature.rawValue) changed to \(featureStatus.statusString)"
        let okAction = WKAlertAction(title: "OK",
                                     style: WKAlertActionStyle.default) {}
        presentAlert(withTitle: alertTitle,
                     message: alertMessage,
                     preferredStyle: WKAlertControllerStyle.alert,
                     actions: [okAction])
    }
}
