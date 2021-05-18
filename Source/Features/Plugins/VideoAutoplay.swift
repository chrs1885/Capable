#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#else
    import Foundation
#endif

class VideoAutoplay: AccessibilityFeatureProtocol {
    static let name = "videoAutoplay"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, tvOS 13.0, *) {
                return UIAccessibility.isVideoAutoplayEnabled
            } else {
                Logger.warning("Unable to determine status for isVideoAutoplayEnabled since it is only available on iOS 13 / tvOS 13 or later.")
                return false
            }

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension VideoAutoplay: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, tvOS 13.0, *) {
                notificationCenter.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: UIAccessibility.videoAutoplayStatusDidChangeNotification,
                    object: nil
                )
            }

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
