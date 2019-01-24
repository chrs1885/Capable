//
//  ColorsViewController.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 21.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import UIKit
import Capable

class ColorsViewController: UIViewController {
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var contrastRatioLabel: UILabel!
    @IBOutlet weak var aaSmallTextView: ConformanceLevelView!
    @IBOutlet weak var aaaSmallTextView: ConformanceLevelView!
    @IBOutlet weak var aaLargeTextView: ConformanceLevelView!
    @IBOutlet weak var aaaLargeTextView: ConformanceLevelView!

    var textColor: UIColor = .capableGreen
    var backgroundColor: UIColor = .black
    var contrastRatio: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.contrastRatio = UIColor.getContrastRatio(forTextColor: self.textColor, onBackgroundColor: self.backgroundColor)!
        setupView()
    }
}

// MARK: - Updating Views
extension ColorsViewController {
    func setupView() {
        updateColorButton(button: self.textColorButton, withColor: self.textColor)
        updateColorButton(button: self.backgroundColorButton, withColor: self.backgroundColor)
        updateContrastRatioLabel()

        self.aaSmallTextView.text = "AA"
        self.aaaSmallTextView.text = "AAA"
        self.aaLargeTextView.text = "AA (Large Text)"
        self.aaaLargeTextView.text = "AAA (Large Text)"
        updateConformanceLevelViews()
    }

    func updateColorButton(button: UIButton, withColor color: UIColor) {
        button.backgroundColor = color
        let textColor = UIColor.getTextColor(onBackgroundColor: color)!
        button.setTitleColor(textColor, for: .normal)
    }

    func updateConformanceLevelViews() {
        guard let contrastRatio = self.contrastRatio else { return }

        self.aaSmallTextView.isPassing = contrastRatio >= 4.5
        self.aaaSmallTextView.isPassing = contrastRatio >= 7.0
        self.aaLargeTextView.isPassing = contrastRatio >= 3.0
        self.aaaLargeTextView.isPassing = contrastRatio >= 4.5
    }

    func updateContrastRatioLabel() {
        guard let contrastRatio = self.contrastRatio else { return }
        self.contrastRatioLabel.text = String(format: "%.2f", contrastRatio)
    }
}

// MARK: - Handling User Interaction
extension ColorsViewController {
    @IBAction func colorButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        let colorType: ColorType = button == self.textColorButton ? .textColor : .backgroundColor
        let color = colorType == .textColor ? self.textColor : self.backgroundColor
        let selectionHandler: (UIColor) -> () = {
            selectedColor in

            if colorType == .textColor {
                self.textColor = selectedColor
            } else {
                self.backgroundColor = selectedColor
            }

            self.contrastRatio = UIColor.getContrastRatio(forTextColor: self.textColor, onBackgroundColor: self.backgroundColor)!
            self.updateColorButton(button: button, withColor: selectedColor)
            self.updateContrastRatioLabel()
            self.updateConformanceLevelViews()
        }

        let colorAlert = ColorAlertController.create(withColorType: colorType, color: color, prefferedStyle: .actionSheet, selectionHandler: selectionHandler)
        self.present(colorAlert, animated: true, completion: nil)
    }
}
