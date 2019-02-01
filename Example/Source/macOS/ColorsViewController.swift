//
//  ColorsViewController.swift
//  Example-macOS
//
//  Created by Christoph Wendt on 27.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import AppKit
import Capable

class ColorsViewController: NSViewController {
    @IBOutlet weak var textColorWell: NSColorWell!
    @IBOutlet weak var backgroundColorWell: NSColorWell!
    @IBOutlet weak var contrastRatioLabel: NSTextField!
    @IBOutlet weak var aaSmallTextView: ConformanceLevelView!
    @IBOutlet weak var aaaSmallTextView: ConformanceLevelView!
    @IBOutlet weak var aaLargeTextView: ConformanceLevelView!
    @IBOutlet weak var aaaLargeTextView: ConformanceLevelView!

    var textColor: NSColor = .capableGreen
    var backgroundColor: NSColor = .black
    var contrastRatio: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerObservers()
    }

    override func viewWillDisappear() {
        unregisterObservers()
    }
}

// MARK: - Updating Views
extension ColorsViewController {
    func setupView() {
        self.textColorWell.color = self.textColor
        self.backgroundColorWell.color = self.backgroundColor
        updateContrastRatio()

        self.aaSmallTextView.text = "AA"
        self.aaaSmallTextView.text = "AAA"
        self.aaLargeTextView.text = "AA (Large Text)"
        self.aaaLargeTextView.text = "AAA (Large Text)"
        updateConformanceLevelViews()
    }

    func updateConformanceLevelViews() {
        guard let contrastRatio = self.contrastRatio else { return }

        self.aaSmallTextView.isPassing = contrastRatio >= 4.5
        self.aaaSmallTextView.isPassing = contrastRatio >= 7.0
        self.aaLargeTextView.isPassing = contrastRatio >= 3.0
        self.aaaLargeTextView.isPassing = contrastRatio >= 4.5
    }

    func updateContrastRatio() {
        if let contrastRatio = NSColor.getContrastRatio(forTextColor: self.textColor, onBackgroundColor: self.backgroundColor) {
            self.contrastRatio = contrastRatio
            self.contrastRatioLabel.stringValue = String(format: "%.2f", contrastRatio)
        }
    }
}

// MARK: - Handling Color Selection
extension ColorsViewController {
    func colorChanged(_ sender : NSColorWell) {
        if sender == self.textColorWell {
            self.textColor = sender.color
        } else if sender == self.backgroundColorWell {
            self.backgroundColor = sender.color
        }

        updateContrastRatio()
        updateConformanceLevelViews()
    }
}

// MARK: - ColorWell Observation
extension ColorsViewController {
    func registerObservers() {
        self.textColorWell.addObserver(self, forKeyPath: "color", options: .new, context: nil)
        self.backgroundColorWell.addObserver(self, forKeyPath: "color", options: .new, context: nil)
    }

    func unregisterObservers() {
        self.textColorWell.removeObserver(self, forKeyPath:"color")
        self.backgroundColorWell.removeObserver(self, forKeyPath:"color")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath! == "color") {
            guard let colorWell = object as? NSColorWell else {
                return
            }

            colorChanged(colorWell)
        }
    }
}

