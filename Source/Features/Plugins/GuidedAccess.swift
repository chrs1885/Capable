#if os(iOS)
    import UIKit
#endif

struct GuidedAccess: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isAssistiveTouchRunning

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
