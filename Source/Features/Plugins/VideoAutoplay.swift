#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif

struct VideoAutoplay: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, tvOS 13.0, *) {
                return UIAccessibility.isVideoAutoplayEnabled
            } else {
                Logger.warning("Unable to determine status for isVideoAutoplayEnabled since it is only available on iOS 13 / tvOS 13 or later.")
                return false
            }

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
