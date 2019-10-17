//
//  FontsConstants.swift
//  Example-iOS
//
//  Created by Wendt, Christoph on 27.07.18.
//  Copyright © 2018 Christoph Wendt. All rights reserved.
//

import UIKit

struct FontsConstants {
    static let customFontName: String = "Cardo-Regular"
    static let defaultFontSize: CGFloat = 17.0
    static let defaultText = "This is a sample text"
    static let fontsList: [(font: UIFont, description: String)] = [
        (
            font: UIFont.systemFont(ofSize: defaultFontSize),
            description: "System Font"
        ),
        (
            font: UIFont(name: customFontName, size: defaultFontSize)!,
            description: "Custom Font"
        ),
        (
            font: UIFont.scaledFont(for: UIFont(name: customFontName, size: defaultFontSize)!),
            description: "Scaled Custom Font"
        ),
        (
            font: UIFont.scaledSystemFont(ofSize: defaultFontSize),
            description: "Scaled System Font"
        ),
        (
            font: UIFont.scaledBoldSystemFont(ofSize: defaultFontSize),
            description: "Scaled Bold System Font"
        ),
        (
            font: UIFont.scaledItalicSystemFont(ofSize: defaultFontSize),
            description: "Scaled Italic System Font"
        ),
    ]
}
