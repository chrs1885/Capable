//
//  FontMetricsProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 31.03.18.
//

import Foundation
import UIKit

protocol FontMetricsProtocol {
    func scaledFont(for font: UIFont) -> UIFont
    func scaledFontPriorIOS11(for font: UIFont) -> UIFont
    func scaledFontSinceIOS11(for font: UIFont) -> UIFont
}
