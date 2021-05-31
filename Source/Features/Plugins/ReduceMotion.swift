#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#elseif os(watchOS)
    import WatchKit
#endif

class ReduceMotion: FeatureProtocol {
    static let name = "reduceMotion"
    let notificationCenter: NotificationCenterProtocol

    #if os(OSX)

        private var displayOptionStatus: Bool = false

    #endif

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isReduceMotionEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldReduceMotion

        #elseif os(watchOS)

            if #available(watchOS 4.0, *) {
                return WKAccessibilityIsReduceMotionEnabled()
            } else {
                Logger.warning("Unable to determine status for isReduceMotion since it is only available on watchOS 4 or later.")
                return false
            }

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension ReduceMotion: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.reduceMotionStatusDidChangeNotification,
                object: nil
            )

        #elseif os(watchOS)

            if #available(watchOS 4.0, *) {
                notificationCenter.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: .WKAccessibilityReduceMotionStatusDidChange,
                    object: nil
                )
            }

        #elseif os(OSX)

            displayOptionStatus = isEnabled
            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        #if os(OSX)

            guard isEnabled != displayOptionStatus else { return }
            displayOptionStatus = isEnabled

        #endif

        postNotification(featureName: Self.name, statusString: status)
    }
}
