#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#elseif os(watchOS)
    import WatchKit
#endif

class VoiceOver: FeatureProtocol {
    static let name = "voiceOver"
    let notificationCenter: NotificationCenterProtocol

    #if os(OSX)

        private var keyValueObservation: NSKeyValueObservation?

    #endif

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isVoiceOverRunning

        #elseif os(OSX)

            return NSWorkspace.shared.isVoiceOverEnabled

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

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.voiceOverStatusDidChangeNotification,
                object: nil
            )

        #elseif os(watchOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged),
                object: nil
            )

        #elseif os(OSX)

            keyValueObservation = NSWorkspace.shared.observe(\NSWorkspace.isVoiceOverEnabled) { _, _ in
                self.valueChanged()
            }

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
