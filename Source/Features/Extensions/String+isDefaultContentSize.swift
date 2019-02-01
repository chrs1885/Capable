//
//  String+isDefaultContentSize.swift
//  Capable
//
//  Created by Christoph Wendt on 15.11.18.
//

#if os(watchOS)

import WatchKit

extension String {
    struct DefaultContentSize {
        // 38mm
        static let small = "UICTContentSizeCategoryS"
        // 42mm
        static let large = "UICTContentSizeCategoryL"
    }

    var isDefaultContentSizeString: Bool {
        let watchSize = WKInterfaceDevice.current().preferredContentSizeCategory
        if watchSize == DefaultContentSize.small {
            return self == "S"
        } else if watchSize == DefaultContentSize.large {
            return self == "L"
        } else {
            return false
        }
    }
}

#endif
