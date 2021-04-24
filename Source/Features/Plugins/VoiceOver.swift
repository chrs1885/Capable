#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#elseif os(watchOS)
    import WatchKit
#endif

class VoiceOver: AccessibilityFeatureProtocol {
    static let name = "voiceOver"

    #if os(OSX)

        var keyValueObservation: NSKeyValueObservation?

    #endif

    init() {
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isVoiceOverRunning

        #elseif os(OSX)

            if #available(OSX 10.13, *) {
                return NSWorkspace.shared.isVoiceOverEnabled
            } else {
                Logger.warning("Unable to determine status for voiceOver since it is only available on macOS 10.13 or later.")
                return false
            }

        #elseif os(watchOS)

            return WKAccessibilityIsVoiceOverRunning()

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension VoiceOver: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            if #available(iOS 11.0, tvOS 11.0, *) {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: UIAccessibility.voiceOverStatusDidChangeNotification,
                    object: nil
                )
            } else {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: Notification.Name(UIAccessibilityVoiceOverStatusChanged),
                    object: nil
                )
            }

        #elseif os(watchOS)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(valueChanged),
                name: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged),
                object: nil
            )

        #elseif os(OSX)

            if #available(OSX 10.13, *) {
                keyValueObservation = NSWorkspace.shared.observe(\NSWorkspace.isVoiceOverEnabled) { _, _ in
                    self.valueChanged()
                }
            }

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
