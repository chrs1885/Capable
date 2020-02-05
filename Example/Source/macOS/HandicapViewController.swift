//
//  HandicapViewController.swift
//  Example-macOS
//
//  Created by Christoph Wendt on 19.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Capable
import Cocoa

class HandicapViewController: NSViewController {
    @IBOutlet var handicapTableView: NSTableView!
    var capable: Capable?
    var objects: [String: String]?
    var handicaps: [Handicap]?
    var alert: NSAlert?

    override func viewDidLoad() {
        super.viewDidLoad()
        let lowVision = Handicap(features: [.increaseContrast, .invertColors, .reduceTransparency], name: "Low Vision", enabledIf: .oneFeatureEnabled)
        capable = Capable(withHandicaps: [lowVision])
        handicaps = [lowVision]
        refreshData()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        registerObservers()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        unregisterObservers()
    }

    func refreshData() {
        if let capable = self.capable {
            objects = capable.statusMap
        }
    }
}

// MARK: - Table View

extension HandicapViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in _: NSTableView) -> Int {
        return objects?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, viewFor _: NSTableColumn?, row: Int) -> NSView? {
        let cell: HandicapTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HandicapRow"), owner: self) as! HandicapTableCellView
        let status = value(forRow: row)
        let handicap = self.handicap(forName: status.key)
        cell.textLabel!.stringValue = handicap.name
        cell.subtitleTextLabel!.stringValue = CapableFeature.keys(forFeatures: handicap.features).joined(separator: ", ")
        cell.detailTextLabel!.stringValue = status.value

        return cell
    }

    func value(forRow row: Int) -> (key: String, value: String) {
        if let objects = self.objects {
            let handicapArray = Array(objects)
            return handicapArray[row]
        }
        fatalError("Requested item does not exist")
    }

    func handicap(forName name: String) -> Handicap {
        for handicap in handicaps! {
            if handicap.name == name {
                return handicap
            }
        }
        fatalError("Requested item does not exist")
    }
}

// MARK: - Toolbar actions

extension HandicapViewController {
    @IBAction func refresh(_: Any) {
        refreshData()
        handicapTableView.reloadData()
    }
}

// MARK: Capable Notification

extension HandicapViewController {
    @objc private func handicapStatusChanged(notification: NSNotification) {
        if let handicapStatus = notification.object as? HandicapStatus {
            showAlert(for: handicapStatus)
            refreshData()
            handicapTableView.reloadData()
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
        let alert = NSAlert()
        alert.messageText = "Handicap status changed"
        alert.informativeText = "\(handicapStatus.handicap.name) changed to \(handicapStatus.statusString)"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")

        self.alert = alert
        self.alert?.runModal()
    }
}
