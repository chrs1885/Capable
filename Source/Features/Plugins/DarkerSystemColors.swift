#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class DarkerSystemColors: AccessibilityFeatureProtocol {
    static let name = "darkerSystemColors"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isDarkerSystemColorsEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension DarkerSystemColors: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.darkerSystemColorsStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
