#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class AssistiveTouch: FeatureProtocol {
    static let name = "assistiveTouch"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

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
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
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
