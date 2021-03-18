#if os(iOS)
    import UIKit
#endif

struct SpeakSelection: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isSpeakSelectionEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
