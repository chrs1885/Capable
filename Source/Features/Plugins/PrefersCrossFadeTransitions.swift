//
//  PrefersCrossFadeTransitions.swift
//  Pods
//
//  Created by Christoph Wendt on 22.06.21.
//

#if os(iOS)
    import UIKit
#endif

class PrefersCrossFadeTransitions: FeatureProtocol {
    static let name = "prefersCrossFadeTransitions"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)
            if #available(iOS 14.0, *) {
                return UIAccessibility.prefersCrossFadeTransitions
            } else {
                Logger.warning("Unable to determine status for prefersCrossFadeTransitions since it is only available on iOS 14 or later.")
                return false
            }

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension PrefersCrossFadeTransitions: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            if #available(iOS 14.0, *) {
                notificationCenter.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: UIAccessibility.prefersCrossFadeTransitionsStatusDidChange,
                    object: nil
                )
            }
        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
