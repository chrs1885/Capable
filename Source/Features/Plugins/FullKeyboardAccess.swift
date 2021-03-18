#if os(OSX)
    import AppKit
#endif

struct FullKeyboardAccess: FeatureProtocol {
    var isEnabled: Bool {
        #if os(OSX)

            return NSApplication.shared.isFullKeyboardAccessEnabled

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
