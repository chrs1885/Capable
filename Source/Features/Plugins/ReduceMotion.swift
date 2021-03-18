#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#elseif os(watchOS)
    import WatchKit
#endif

struct ReduceMotion: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isReduceMotionEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldReduceMotion

        #elseif os(watchOS)

            if #available(watchOS 4.0, *) {
                return WKAccessibilityIsReduceMotionEnabled()
            } else {
                Logger.warning("Unable to determine status for isReduceMotion since it is only available on watchOS 4 or later.")
                return false
            }

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
