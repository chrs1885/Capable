#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class OnOffSwitchLabels: FeatureProtocol {
    static let name = "onOffSwitchLabels"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, tvOS 13.0, *) {
                return UIAccessibility.isOnOffSwitchLabelsEnabled
            } else {
                Logger.warning("Unable to determine status for isOnOffSwitchLabelsEnabled since it is only available on iOS 13 or later.")
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

extension OnOffSwitchLabels: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, tvOS 13.0, *) {
                notificationCenter.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: UIAccessibility.onOffSwitchLabelsDidChangeNotification,
                    object: nil
                )
            }

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
