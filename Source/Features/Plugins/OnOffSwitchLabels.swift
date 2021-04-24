#if os(iOS)
    import UIKit
#else
    import Foundation
#endif

class OnOffSwitchLabels: AccessibilityFeatureProtocol {
    static let name = "onOffSwitchLabels"

    init() {
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
        #if os(iOS)

            if #available(iOS 13.0, *) {
                NotificationCenter.default.addObserver(
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
