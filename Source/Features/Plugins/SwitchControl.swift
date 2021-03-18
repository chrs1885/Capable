#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

struct SwitchControl: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isSwitchControlRunning

        #elseif os(OSX)

            if #available(OSX 10.13, *) {
                return NSWorkspace.shared.isSwitchControlEnabled
            } else {
                Logger.warning("Unable to determine status for switchControl since it is only available on macOS 10.13 or later.")
                return false
            }

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
