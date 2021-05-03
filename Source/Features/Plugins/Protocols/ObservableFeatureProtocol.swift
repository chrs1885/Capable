import Foundation

protocol ObservableFeatureProtocol {
    var notificationCenter: NotificationCenterProtocol { get }
}

extension ObservableFeatureProtocol {
    func postNotification(featureName: String, statusString: String) {
        guard let feature = CapableFeature(rawValue: featureName) else { return }

        let featureStatus = FeatureStatus(feature: feature, statusString: statusString)
        notificationCenter.post(name: .CapableFeatureStatusDidChange, object: featureStatus)

        Logger.info("Posted notification for feature \(feature) set to \(statusString)")
    }
}
