//
//  HandicapViewController.swift
//  Example-macOS
//
//  Created by Christoph Wendt on 19.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Cocoa
import Capable

class HandicapViewController: NSViewController {
    @IBOutlet weak var handicapTableView: NSTableView!
    var capable: Capable?
    var objects: [String: String]?
    var handicaps: [Handicap]?
    var alert: NSAlert?

    override func viewDidLoad() {
        super.viewDidLoad()
        let lowVision = Handicap(features: [.increaseContrast, .invertColors, .reduceTransparency], name: "Low Vision", enabledIf: .oneFeatureEnabled)
        self.capable = Capable(withHandicaps: [lowVision])
        self.handicaps = [lowVision]
        self.refreshData()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        self.registerObservers()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        self.unregisterObservers()
    }

    func refreshData() {
        if let capable = self.capable {
            self.objects = capable.statusMap
        }
    }
}

// MARK: - Table View
extension HandicapViewController: NSTableViewDataSource, NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return objects?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        let cell: HandicapTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HandicapRow"), owner: self) as! HandicapTableCellView
        let status = self.value(forRow: row)
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
        for handicap in self.handicaps! {
            if handicap.name == name {
                return handicap
            }
        }
        fatalError("Requested item does not exist")
    }
}

// MARK: - Toolbar actions
extension HandicapViewController {
    @IBAction func refresh(_ sender: Any) {
        self.refreshData()
        self.handicapTableView.reloadData()
    }
}

// MARK: Capable Notification
extension HandicapViewController {
    @objc private func handicapStatusChanged(notification: NSNotification) {
        if let handicapStatus = notification.object as? HandicapStatus {
            self.showAlert(for: handicapStatus)
            refreshData()
            self.handicapTableView.reloadData()
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

