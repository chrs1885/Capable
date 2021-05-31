#if os(OSX)
    import AppKit
#else
    import Foundation
#endif

class IncreaseContrast: FeatureProtocol {
    static let name = "increaseContrast"
    let notificationCenter: NotificationCenterProtocol

    #if os(OSX)

        private var displayOptionStatus: Bool = false

    #endif

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension IncreaseContrast: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(OSX)

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
