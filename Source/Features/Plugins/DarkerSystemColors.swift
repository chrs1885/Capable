#if os(iOS) || os(tvOS)
    import UIKit
#endif

struct DarkerSystemColors: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            return UIAccessibility.isDarkerSystemColorsEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
