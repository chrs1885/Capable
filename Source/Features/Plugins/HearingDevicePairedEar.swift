#if os(iOS)
    import UIKit
#else
    import Foundation
#endif

class HearingDevicePairedEar: AccessibilityFeatureProtocol {
    static let name = "hearingDevicePairedEar"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)

            return hearingDevicePairedEar.rawValue != 0

        #else

            return false

        #endif
    }

    var status: String {
        #if os(iOS)

            return hearingDevicePairedEar.statusString

        #else

            return isEnabled.statusString

        #endif
    }
}

private extension HearingDevicePairedEar {
    #if os(iOS)

        var hearingDevicePairedEar: UIAccessibility.HearingDeviceEar {
            return UIAccessibility.hearingDevicePairedEar
        }

    #endif
}

extension HearingDevicePairedEar: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.hearingDevicePairedEarDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
