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
    @IBOutlet weak var featuresTableView:NSTableView!
    var objects: [String: String]?
    var capable: Capable?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.capable = Capable()
        refreshData()
    }

    func refreshData() {
        if let capable = self.capable {
            self.objects = capable.statusMap
        }
    }
}

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
