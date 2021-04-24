#if os(iOS)
    import UIKit
#else
    import Foundation
#endif

class SpeakScreen: AccessibilityFeatureProtocol {
    static let name = "speakScreen"

    init() {
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isSpeakScreenEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension SpeakScreen: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.speakScreenStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
