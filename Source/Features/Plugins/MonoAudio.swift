#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

class MonoAudio: AccessibilityFeatureProtocol {
    static let name = "monoAudio"

    init() {
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isMonoAudioEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension MonoAudio: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.monoAudioStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
