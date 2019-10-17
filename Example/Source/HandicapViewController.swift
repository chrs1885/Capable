//
//  HandicapViewController.swift
//  Example
//
//  Created by Christoph Wendt on 17.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Capable
import UIKit

class HandicapViewController: UITableViewController {
    var alert: UIAlertController?
    var capable: Capable?
    var objects: [String: String]?
    var handicaps: [Handicap]?

    override func viewDidLoad() {
        super.viewDidLoad()
        #if os(iOS)
            let blindness = Handicap(features: [.speakScreen, .speakSelection, .voiceOver], name: "Blindness", enabledIf: .oneFeatureEnabled)
            capable = Capable(withHandicaps: [blindness])
            handicaps = [blindness]
        #else
            let lowVision = Handicap(features: [.boldText, .invertColors, .reduceTransparency], name: "Low Vision ", enabledIf: .oneFeatureEnabled)
            capable = Capable(withHandicaps: [lowVision])
            handicaps = [lowVision]
        #endif

        registerObservers()
        refreshData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterObservers()
    }

    func refreshData() {
        if let capable = self.capable {
            objects = capable.statusMap
        }
    }
}

// MARK: - Table View

extension HandicapViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return objects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = indexPath.row
        let status = value(forRow: row)
        let handicap = self.handicap(forName: status.key)
        cell.textLabel!.text = handicap.name
        cell.detailTextLabel!.text = CapableFeature.keys(forFeatures: handicap.features).joined(separator: ", ")
        cell.accessoryType = status.value == "enabled" ? .checkmark : .none

        return cell
    }

    private func value(forRow row: Int) -> (key: String, value: String) {
        if let objects = self.objects {
            let featuresArray = Array(objects)
            return featuresArray[row]
        }
        fatalError("Requested item does not exist")
    }

    private func handicap(forName name: String) -> Handicap {
        for handicap in handicaps! {
            if handicap.name == name {
                return handicap
            }
        }
        fatalError("Requested item does not exist")
    }
}

// MARK: Capable Notification

extension HandicapViewController {
    @objc private func handicapStatusChanged(notification: NSNotification) {
        if let handicapStatus = notification.object as? HandicapStatus {
            showAlert(for: handicapStatus)
            refreshData()
            tableView.reloadData()
        }
    }

    func registerObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handicapStatusChanged),
            name: .CapableHandicapStatusDidChange,
            object: nil
        )
    }

    func unregisterObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Alert

extension HandicapViewController {
    private func showAlert(for handicapStatus: HandicapStatus) {
        let showNewAlert = {
            let alertTitle = "Handicap status changed"
            let alertMessage = "\(handicapStatus.handicap.name) changed to \(handicapStatus.statusString)"
            self.alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            if let alert = self.alert {
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }

        dismissAlertIfNeeded(completion: showNewAlert)
    }

    private func dismissAlertIfNeeded(completion: @escaping () -> Void) {
        if alert != nil, presentedViewController == alert {
            alert!.dismiss(animated: false) {
                completion()
            }
        } else {
            completion()
        }
    }
}
