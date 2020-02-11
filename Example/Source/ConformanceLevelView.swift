//
//  ConformanceLevelView.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 21.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

#if os(iOS)

    import UIKit
    typealias TypeFont = UIFont
    typealias Label = UILabel
    typealias View = UIView

#elseif os(OSX)

    import AppKit
    typealias TypeFont = NSFont
    typealias Label = NSTextField
    typealias View = NSView

#endif

class ConformanceLevelView: View {
    private let textLabel = Label()

    var text: String = "" {
        didSet {
            #if os(iOS)
                textLabel.text = text
            #elseif os(OSX)
                textLabel.stringValue = text
                textLabel.isEditable = false
            #endif
        }
    }

    var isPassing: Bool = false {
        didSet {
            self.backgroundColor = isPassing ? TypeColor.capableGreen : TypeColor.capableRed
            self.textLabel.textColor = TypeColor.getTextColor(onBackgroundColor: self.backgroundColor!)!
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        addSubview(textLabel)
        textLabel.font = TypeFont.systemFont(ofSize: 13.0)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = ["textLabel": self.textLabel]
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textLabel]-8-|", metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[textLabel]-8-|", metrics: nil, views: views)
        NSLayoutConstraint.activate(allConstraints)

        isPassing = true
    }
}
