#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#else
    import Foundation
#endif

class BoldText: AccessibilityFeatureProtocol {
    static let name = "boldText"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isBoldTextEnabled

        #elseif os(watchOS)

            let referenceFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
            let isBoldText = referenceFont.fontName.localizedCaseInsensitiveContains("bold")
            return isBoldText

        #else

            return false

        #endif
    }

    var status: String {
        isEnabled.statusString
    }
}

extension BoldText: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS) || os(tvOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIAccessibility.boldTextStatusDidChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
