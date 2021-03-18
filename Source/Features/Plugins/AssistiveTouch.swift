#if os(iOS)
    import UIKit
#endif

struct AssistiveTouch: FeatureProtocol {
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
