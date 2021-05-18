#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class ClosedCaptioning: AccessibilityFeatureProtocol {
    static let name = "closedCaptioning"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isClosedCaptioningEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension ClosedCaptioning: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.closedCaptioningStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
