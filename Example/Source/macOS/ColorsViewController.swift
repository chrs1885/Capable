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
    @IBOutlet var textColorWell: NSColorWell!
    @IBOutlet var backgroundColorWell: NSColorWell!
    @IBOutlet var contrastRatioLabel: NSTextField!
    @IBOutlet var aaSmallTextView: ConformanceLevelView!
    @IBOutlet var aaaSmallTextView: ConformanceLevelView!
    @IBOutlet var aaLargeTextView: ConformanceLevelView!
    @IBOutlet var aaaLargeTextView: ConformanceLevelView!

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
        textColorWell.color = textColor
        backgroundColorWell.color = backgroundColor
        updateContrastRatio()

        aaSmallTextView.text = "AA"
        aaaSmallTextView.text = "AAA"
        aaLargeTextView.text = "AA (Large Text)"
        aaaLargeTextView.text = "AAA (Large Text)"
        updateConformanceLevelViews()
    }

    func updateConformanceLevelViews() {
        guard let contrastRatio = self.contrastRatio else { return }

        aaSmallTextView.isPassing = contrastRatio >= 4.5
        aaaSmallTextView.isPassing = contrastRatio >= 7.0
        aaLargeTextView.isPassing = contrastRatio >= 3.0
        aaaLargeTextView.isPassing = contrastRatio >= 4.5
    }

    func updateContrastRatio() {
        if let contrastRatio = NSColor.getContrastRatio(forTextColor: self.textColor, onBackgroundColor: self.backgroundColor) {
            self.contrastRatio = contrastRatio
            contrastRatioLabel.stringValue = String(format: "%.2f", contrastRatio)
        }
    }
}

// MARK: - Handling Color Selection

extension ColorsViewController {
    func colorChanged(_ sender: NSColorWell) {
        if sender == textColorWell {
            textColor = sender.color
        } else if sender == backgroundColorWell {
            backgroundColor = sender.color
        }

        updateContrastRatio()
        updateConformanceLevelViews()
    }
}

// MARK: - ColorWell Observation

extension ColorsViewController {
    func registerObservers() {
        textColorWell.addObserver(self, forKeyPath: "color", options: .new, context: nil)
        backgroundColorWell.addObserver(self, forKeyPath: "color", options: .new, context: nil)
    }

    func unregisterObservers() {
        textColorWell.removeObserver(self, forKeyPath: "color")
        backgroundColorWell.removeObserver(self, forKeyPath: "color")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        if keyPath! == "color" {
            guard let colorWell = object as? NSColorWell else {
                return
            }

            colorChanged(colorWell)
        }
    }
}
