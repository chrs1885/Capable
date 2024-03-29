#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class GuidedAccess: FeatureProtocol {
    static let name = "guidedAccess"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isGuidedAccessEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension GuidedAccess: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.guidedAccessStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
