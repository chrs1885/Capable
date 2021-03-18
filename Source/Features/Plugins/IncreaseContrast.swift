#if os(OSX)
    import AppKit
#endif

struct IncreaseContrast: FeatureProtocol {
    var isEnabled: Bool {
        #if os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}
