#if os(iOS) || os(tvOS)
    import UIKit
#endif

struct Grayscale: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isGrayscaleEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
