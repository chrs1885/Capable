//
//  HearingDeviceEar+stringValue.swift
//  Capable
//
//  Created by Christoph Wendt on 15.11.18.
//

#if os(iOS)

import UIKit

extension UIAccessibility.HearingDeviceEar {
    var statusString: String {
        switch self {
        case .both:
            return "both"
        case .left:
            return "left"
        case .right:
            return "right"
        default:
            return "disabled"
        }
    }
}

#endif
