//
//  CaptionsViewController.swift
//  Example-macOS
//
//  Created by Wendt, Christoph on 28.09.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import AppKit
import Capable

class CaptionsViewController: NSViewController {
    @IBOutlet var progressIndicator: NSProgressIndicator!
    @IBOutlet var content: NSView!
    @IBOutlet var topLeftLabel: NSTextField!
    @IBOutlet var topCenterLabel: NSTextField!
    @IBOutlet var topRightLabel: NSTextField!
    @IBOutlet var centerLeftLabel: NSTextField!
    @IBOutlet var centerLabel: NSTextField!
    @IBOutlet var centerRightLabel: NSTextField!
    @IBOutlet var bottomLeftLabel: NSTextField!
    @IBOutlet var bottomCenterLabel: NSTextField!
    @IBOutlet var bottomRightLabel: NSTextField!

    var isLoading: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.content.isHidden = self.isLoading

                if self.isLoading {
                    self.progressIndicator.startAnimation(nil)
                } else {
                    self.progressIndicator.stopAnimation(nil)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelColors()
    }

    private func setupLabelColors() {
        let backgroundImage = NSImage(named: "captions_gradient")!
        let labels: [NSTextField: ImageArea] = [
            topLeftLabel: .topLeft,
            topCenterLabel: .topCenter,
            topRightLabel: .topRight,
            centerLeftLabel: .centerLeft,
            centerLabel: .center,
            centerRightLabel: .centerRight,
            bottomLeftLabel: .bottomLeft,
            bottomCenterLabel: .bottomCenter,
            bottomRightLabel: .bottomRight,
        ]

        isLoading = true
        DispatchQueue.global(qos: .background).async {
            for label in labels {
                let textColor = NSColor.getTextColor(onBackgroundImage: backgroundImage, imageArea: label.value)

                DispatchQueue.main.async {
                    label.key.textColor = textColor
                }
            }
            self.isLoading = false
        }
    }
}
