//
//  MasterViewController.swift
//  Example
//
//  Created by Christoph Wendt on 23.03.18.
//

import UIKit
import Capable

#if os(iOS)
import Fabric
import Answers
import AppCenter
import AppCenterAnalytics
import Firebase
#endif

class FeatureOverviewController: UITableViewController {
    var alert: UIAlertController?
    var objects: [String: String]?
    var capable: Capable?
    
    override func viewDidLoad() {
//        self.capable = Capable(with: [.LargerText, .BoldText, .ShakeToUndo])
        self.capable = Capable()
        refreshData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.featureStatusChanged),
            name: .CapableFeatureStatusDidChange,
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.capable?.notificationsEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.capable?.notificationsEnabled = false
    }
    
    func refreshData() {
        if let capable = self.capable {
            self.objects = capable.statusMap
        }
    }
    
    func sendMetrics() {
        // The purpose of this function is to test API compatibility. To actually send telemetry, register each SDK
        // in the AppDelegate's didFinishLaunchingWithOptions callback
        #if os(iOS)
        if let statusMap = self.capable?.statusMap {
            let eventName = "Capable features received"
            MSAnalytics.trackEvent(eventName, withProperties: statusMap)
            Analytics.logEvent(eventName, parameters: statusMap)
            Answers.logCustomEvent(withName: eventName, customAttributes: statusMap)
        }
        #endif
    }
}

// MARK: - Table View
extension FeatureOverviewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let feature = self.value(forRow: indexPath.row)
        cell.textLabel!.text = feature.key
        cell.detailTextLabel!.text = feature.value
        
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

// MARK: Capable Notification
extension FeatureOverviewController {
    @objc private func featureStatusChanged(notification: NSNotification) {
        if let featureStatus = notification.object as? FeatureStatus {
            self.showAlert(for: featureStatus)
            refreshData()
            self.tableView.reloadData()
        }
    }
}

// MARK: Alert
extension FeatureOverviewController {
    private func showAlert(for featureStatus: FeatureStatus) {
        let showNewAlert = {
            let alertTitle = "Feature status changed"
            let alertMessage = "\(featureStatus.feature.rawValue) changed to \(featureStatus.statusString)"
            self.alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            if let alert = self.alert {
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        self.dismissAlertIfNeeded(completion: showNewAlert)
    }
    
    private func dismissAlertIfNeeded(completion: @escaping () -> ()) {
        if self.alert != nil, self.presentedViewController == self.alert {
            self.alert!.dismiss(animated: false) {
                completion()
            }
        } else {
            completion()
        }
    }
}

