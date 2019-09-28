//
//  ConformanceLevelView.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 21.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

#if os(iOS)

import UIKit
typealias Font = UIFont
typealias Label = UILabel
typealias View = UIView

#elseif os(OSX)

import AppKit
typealias Font = NSFont
typealias Label = NSTextField
typealias View = NSView

#endif

class ConformanceLevelView: View {
    private let textLabel = Label()

    var text: String = "" {
        didSet {
            #if os(iOS)
                self.textLabel.text = text
            #elseif os(OSX)
                self.textLabel.stringValue = text
                self.textLabel.isEditable = false
            #endif
        }
    }

    var isPassing: Bool = false {
        didSet {
            self.backgroundColor = isPassing ? Color.capableGreen : Color.capableRed
            self.textLabel.textColor = Color.getTextColor(onBackgroundColor: self.backgroundColor!)!
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        self.addSubview(textLabel)
        self.textLabel.font = Font.preferredFont(forTextStyle: .body)
        self.textLabel.numberOfLines = 0

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = ["textLabel": self.textLabel]
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textLabel]-8-|", metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[textLabel]-8-|", metrics: nil, views: views)
        NSLayoutConstraint.activate(allConstraints)

        self.isPassing = true
    }
}
