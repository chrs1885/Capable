#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#elseif os(watchOS)
    import WatchKit
#endif

struct VoiceOver: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isVoiceOverRunning

        #elseif os(OSX)

            if #available(OSX 10.13, *) {
                return NSWorkspace.shared.isVoiceOverEnabled
            } else {
                Logger.warning("Unable to determine status for voiceOver since it is only available on macOS 10.13 or later.")
                return false
            }

        #elseif os(watchOS)

            return WKAccessibilityIsVoiceOverRunning()

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
