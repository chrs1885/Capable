#if os(iOS) || os(tvOS)
    import UIKit
#endif

struct MonoAudio: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isMonoAudioEnabled

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
