//
//  ViewController.swift
//  Example-macOS
//
//  Created by Christoph Wendt on 01.08.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import Cocoa
import Capable

class FeatureOverviewController: NSViewController {
    @IBOutlet weak var featuresTableView: NSTableView!
    var objects: [String: String]?
    var capable: Capable?
    var alert: NSAlert?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.capable = Capable()
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
extension FeatureOverviewController: NSTableViewDataSource, NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return objects?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        let cell: FeatureTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeatureRow"), owner: self) as! FeatureTableCellView
        let feature = self.value(forRow: row)
        cell.textLabel.stringValue = feature.key
        cell.detailTextLabel.stringValue = feature.value

        return cell
    }

    private func value(forRow row: Int) -> (key: String, value: String) {
        if let objects = self.objects {
            let featuresArray = Array(objects)
            return featuresArray[row]
        }
        fatalError("Requested item does not exist")
    }
}

// MARK: - Toolbar actions
extension FeatureOverviewController {
    @IBAction func refresh(_ sender: Any) {
        self.refreshData()
        self.featuresTableView.reloadData()
    }
}

// MARK: Capable Notification
extension FeatureOverviewController {
    @objc private func featureStatusChanged(notification: NSNotification) {
        if let featureStatus = notification.object as? FeatureStatus {
            self.showAlert(for: featureStatus)
            refreshData()
            self.featuresTableView.reloadData()
        }
    }

    func registerObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.featureStatusChanged),
            name: .CapableFeatureStatusDidChange,
            object: nil)
    }

    func unregisterObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Alert
extension FeatureOverviewController {
    private func showAlert(for featureStatus: FeatureStatus) {
        let alert = NSAlert()
        alert.messageText = "Feature status changed"
        alert.informativeText = "\(featureStatus.feature.rawValue) changed to \(featureStatus.statusString)"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")

        self.alert = alert
        self.alert?.runModal()
    }
}
