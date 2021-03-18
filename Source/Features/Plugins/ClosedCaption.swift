#if os(iOS) || os(tvOS)
    import UIKit
#endif

struct ClosedCaption: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isClosedCaptioningEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
