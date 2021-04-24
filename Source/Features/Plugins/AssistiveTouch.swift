#if os(iOS)
    import UIKit
#else
    import Foundation
#endif

class AssistiveTouch: AccessibilityFeatureProtocol {
    static let name = "assistiveTouch"

    init() {
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isAssistiveTouchRunning

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension AssistiveTouch: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.assistiveTouchStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
