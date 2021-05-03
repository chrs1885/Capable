#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#else
    import Foundation
#endif

class InvertColors: AccessibilityFeatureProtocol {
    static let name = "invertColors"
    var notificationCenter: NotificationCenterProtocol
    
    #if os(OSX)

        private var displayOptionStatus: Bool = false

    #endif

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isInvertColorsEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldInvertColors

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension InvertColors: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.invertColorsStatusDidChangeNotification,
                object: nil
            )

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
