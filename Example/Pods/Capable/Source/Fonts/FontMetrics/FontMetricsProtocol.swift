//
//  FontMetricsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import Foundation
import UIKit

protocol FontMetricsProtocol {
    func scaledFont(for font: UIFont) -> UIFont
    func scaledFontWithoutUIFontMetrics(for font: UIFont) -> UIFont
    func scaledFontWithUIFontMetrics(for font: UIFont) -> UIFont
}

#endif
