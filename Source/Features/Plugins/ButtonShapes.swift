//
//  ButtonShapes.swift
//  Pods
//
//  Created by Christoph Wendt on 19.06.21.
//

#if os(iOS)
    import UIKit
#endif

class ButtonShapes: FeatureProtocol {
    static let name = "buttonShapes"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)
            if #available(iOS 14.0, *) {
                return UIAccessibility.buttonShapesEnabled
            } else {
                Logger.warning("Unable to determine status for buttonShapesEnabled since it is only available on iOS 14 or later.")
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

extension ButtonShapes: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            if #available(iOS 14.0, *) {
                notificationCenter.addObserver(
                    self,
                    selector: #selector(valueChanged),
                    name: UIAccessibility.buttonShapesEnabledStatusDidChangeNotification,
                    object: nil
                )
            }
        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
