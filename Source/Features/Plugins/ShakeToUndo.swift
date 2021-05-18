#if os(iOS)
    import UIKit
#else
    import Foundation
#endif

class ShakeToUndo: AccessibilityFeatureProtocol {
    static let name = "shakeToUndo"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isShakeToUndoEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension ShakeToUndo: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.shakeToUndoDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
