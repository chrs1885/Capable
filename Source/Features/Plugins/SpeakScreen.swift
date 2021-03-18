#if os(iOS)
    import UIKit
#endif

struct SpeakScreen: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isSpeakScreenEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
