#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#else
    import Foundation
#endif

class DifferentiateWithoutColor: FeatureProtocol {
    static let name = "differentiateWithoutColor"
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

            if #available(iOS 13.0, tvOS 13.0, *) {
                return UIAccessibility.shouldDifferentiateWithoutColor
            } else {
                Logger.warning("Unable to determine status for isDifferentiateWithoutColorEnabled since it is only available on iOS 13 or later.")
                return false
            }

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldDifferentiateWithoutColor

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension DifferentiateWithoutColor: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            if #available(iOS 13.0, tvOS 13.0, *) {
                notificationCenter.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: NSNotification.Name(rawValue: UIAccessibility.differentiateWithoutColorDidChangeNotification),
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
