#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

struct DifferentiateWithoutColor: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            if #available(iOS 13.0, *) {
                return UIAccessibility.shouldDifferentiateWithoutColor
            } else {
                Logger.warning("Unable to determine status for isDifferentiateWithoutColorEnabled since it is only available on iOS 13 or later.")
                return false
            }

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldDifferentiateWithoutColor

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
