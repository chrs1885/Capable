//
//  ConformanceLevelView.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 21.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import UIKit

class ConformanceLevelView: UIView {
    private let textLabel = UILabel()

    var text: String = "" {
        didSet {
            self.textLabel.text = text
        }
    }

    var isPassing: Bool = false {
        didSet {
            self.backgroundColor = isPassing ? UIColor.capableGreen : UIColor.capableRed
            self.textLabel.textColor = UIColor.getTextColor(onBackgroundColor: self.backgroundColor!)!
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        self.addSubview(textLabel)
        self.textLabel.font = UIFont.scaledSystemFont(ofSize: 13.0)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = ["textLabel": self.textLabel]
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textLabel]-8-|", metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[textLabel]-8-|", metrics: nil, views: views)
        NSLayoutConstraint.activate(allConstraints)

        self.isPassing = true
    }
}
