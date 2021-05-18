#if os(iOS)
    import UIKit
#else
    import Foundation
#endif

class SpeakSelection: AccessibilityFeatureProtocol {
    static let name = "speakSelection"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isSpeakSelectionEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension SpeakSelection: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.speakSelectionStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
