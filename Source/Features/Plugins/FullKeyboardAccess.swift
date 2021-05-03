#if os(OSX)
    import AppKit
#else
    import Foundation
#endif

class FullKeyboardAccess: AccessibilityFeatureProtocol {
    static let name = "fullKeyboardAccess"

    var isEnabled: Bool {
        #if os(OSX)

            return NSApplication.shared.isFullKeyboardAccessEnabled

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
