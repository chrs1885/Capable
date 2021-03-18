#if os(iOS)
    import UIKit
#endif

struct ShakeToUndo: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isShakeToUndoEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
