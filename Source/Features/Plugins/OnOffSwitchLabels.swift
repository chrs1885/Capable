#if os(iOS)
    import UIKit
#endif

struct OnOffSwitchLabels: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, *) {
                return UIAccessibility.isOnOffSwitchLabelsEnabled
            } else {
                Logger.warning("Unable to determine status for isOnOffSwitchLabelsEnabled since it is only available on iOS 13 or later.")
                return false
            }

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
