#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

struct ReduceTransparency: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isReduceTransparencyEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldReduceTransparency

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
