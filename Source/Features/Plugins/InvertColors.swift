#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

struct InvertColors: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isInvertColorsEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldInvertColors

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
