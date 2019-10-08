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
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var content: NSView!
    @IBOutlet weak var topLeftLabel: NSTextField!
    @IBOutlet weak var topCenterLabel: NSTextField!
    @IBOutlet weak var topRightLabel: NSTextField!
    @IBOutlet weak var centerLeftLabel: NSTextField!
    @IBOutlet weak var centerLabel: NSTextField!
    @IBOutlet weak var centerRightLabel: NSTextField!
    @IBOutlet weak var bottomLeftLabel: NSTextField!
    @IBOutlet weak var bottomCenterLabel: NSTextField!
    @IBOutlet weak var bottomRightLabel: NSTextField!

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
        let labels: [NSTextField:ImageArea] = [
            topLeftLabel: .topLeft,
            topCenterLabel: .topCenter,
            topRightLabel: .topRight,
            centerLeftLabel: .centerLeft,
            centerLabel: .center,
            centerRightLabel: .centerRight,
            bottomLeftLabel: .bottomLeft,
            bottomCenterLabel: .bottomCenter,
            bottomRightLabel: .bottomRight
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
