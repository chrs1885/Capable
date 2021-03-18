#if os(iOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif

struct LargerText: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS)

            return !largerTextCatagory.isDefault

        #elseif os(watchOS)

            return !largerTextCatagory.isDefaultContentSizeString

        #endif

        return false
    }

    var status: String {
        #if os(iOS)

            return largerTextCatagory.stringValue

        #elseif os(watchOS)

            return largerTextCatagory

        #endif

        return isEnabled.statusString
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
