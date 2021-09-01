#if os(iOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#else
    import Foundation
#endif

class LargerText: FeatureProtocol {
    static let name = "largerText"
    let notificationCenter: NotificationCenterProtocol

    init(notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        registerObservation()
    }

    var isEnabled: Bool {
        #if os(iOS)

            return !largerTextCatagory.isDefault

        #elseif os(watchOS)

            return !largerTextCatagory.isDefaultContentSizeString

        #else

            return false

        #endif
    }

    var status: String {
        #if os(iOS)

            return largerTextCatagory.stringValue

        #elseif os(watchOS)

            return largerTextCatagory

        #else

            return isEnabled.statusString

        #endif
    }
}

private extension LargerText {
    #if os(iOS)

        var largerTextCatagory: UIContentSizeCategory {
            return UIScreen.main.traitCollection.preferredContentSizeCategory
        }

    #elseif os(watchOS)

        var largerTextCatagory: String {
            let referenceFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize
            return referenceFontSize.contentSizeString
        }

    #endif
}

extension LargerText: ObservableFeatureProtocol {
    func registerObservation() {
        #if os(iOS)

            notificationCenter.addObserver(
                self,
                selector: #selector(valueChanged),
                name: UIContentSizeCategory.didChangeNotification,
                object: nil
            )

        #endif
    }

    @objc func valueChanged() {
        postNotification(featureName: Self.name, statusString: status)
    }
}
