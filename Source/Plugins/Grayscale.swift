#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class Grayscale: FeatureProtocol {
    static let name = "grayscale"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isGrayscaleEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension Grayscale: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.grayscaleStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
