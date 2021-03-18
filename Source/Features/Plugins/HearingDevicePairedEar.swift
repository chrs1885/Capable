#if os(iOS)
    import UIKit
#endif

struct HearingDevicePairedEar: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            return hearingDevicePairedEar.rawValue != 0

        #endif

        return false
    }

    var status: String {
        #if os(iOS)

            return hearingDevicePairedEar.statusString

        #endif

        return isEnabled.statusString
    }
}

private extension HearingDevicePairedEar {
    #if os(iOS)

        var hearingDevicePairedEar: UIAccessibility.HearingDeviceEar {
            return UIAccessibility.hearingDevicePairedEar
        }

    #endif
}
