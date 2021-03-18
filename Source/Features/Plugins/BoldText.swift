#if os(iOS) || os(tvOS)
    import UIKit
#endif

struct BoldText: FeatureProtocol {
    var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isBoldTextEnabled

        #elseif os(watchOS)

            let referenceFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
            let isBoldText = referenceFont.fontName.localizedCaseInsensitiveContains("bold")
            return isBoldText

        #endif

        return false
    }

    var status: String {
        isEnabled.statusString
    }
}
