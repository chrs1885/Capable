//
//  ColorsViewController.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 21.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import Capable
import SheetyColors
import UIKit

enum ColorType: String {
    case textColor = "Text Color"
    case backgroundColor = "Background Color"
}

class ColorsViewController: UIViewController {
    @IBOutlet var textColorButton: UIButton!
    @IBOutlet var backgroundColorButton: UIButton!
    @IBOutlet var contrastRatioLabel: UILabel!
    @IBOutlet var aaSmallTextView: ConformanceLevelView!
    @IBOutlet var aaaSmallTextView: ConformanceLevelView!
    @IBOutlet var aaLargeTextView: ConformanceLevelView!
    @IBOutlet var aaaLargeTextView: ConformanceLevelView!

    var textColor: UIColor = .capableGreen
    var backgroundColor: UIColor = .black
    var contrastRatio: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        contrastRatio = UIColor.getContrastRatio(forTextColor: textColor, onBackgroundColor: backgroundColor)!
        setupView()
    }
}

// MARK: - Updating Views

extension ColorsViewController {
    func setupView() {
        updateColorButton(button: textColorButton, withColor: textColor)
        updateColorButton(button: backgroundColorButton, withColor: backgroundColor)
        updateContrastRatioLabel()

        aaSmallTextView.text = "AA"
        aaaSmallTextView.text = "AAA"
        aaLargeTextView.text = "AA (Large Text)"
        aaaLargeTextView.text = "AAA (Large Text)"
        updateConformanceLevelViews()
    }

    func updateColorButton(button: UIButton, withColor color: UIColor) {
        button.backgroundColor = color
        let textColor = UIColor.getTextColor(onBackgroundColor: color)!
        button.setTitleColor(textColor, for: .normal)
    }

    func updateConformanceLevelViews() {
        guard let contrastRatio = self.contrastRatio else { return }

        aaSmallTextView.isPassing = contrastRatio >= 4.5
        aaaSmallTextView.isPassing = contrastRatio >= 7.0
        aaLargeTextView.isPassing = contrastRatio >= 3.0
        aaaLargeTextView.isPassing = contrastRatio >= 4.5
    }

    func updateContrastRatioLabel() {
        guard let contrastRatio = self.contrastRatio else { return }
        contrastRatioLabel.text = String(format: "%.2f", contrastRatio)
    }
}

// MARK: - Handling User Interaction

extension ColorsViewController {
    @IBAction func colorButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        let colorType: ColorType = button == textColorButton ? .textColor : .backgroundColor
        let color = colorType == .textColor ? textColor : backgroundColor
        let alphaEnabled = colorType == .textColor

        let config = SheetyColorsConfig(alphaEnabled: alphaEnabled, hapticFeedbackEnabled: true, initialColor: color, title: "Select a \(colorType.rawValue)", type: .rgb)
        let sheetyColors = SheetyColorsController(withConfig: config)
        let selectAction = UIAlertAction(title: "Save Color", style: .default, handler: { _ in
            let selectedColor = sheetyColors.color
            if colorType == .textColor {
                self.textColor = selectedColor
            } else {
                self.backgroundColor = selectedColor
            }

            self.contrastRatio = UIColor.getContrastRatio(forTextColor: self.textColor, onBackgroundColor: self.backgroundColor)!
            self.updateColorButton(button: button, withColor: selectedColor)
            self.updateContrastRatioLabel()
            self.updateConformanceLevelViews()
        })
        sheetyColors.addAction(selectAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheetyColors.addAction(cancelAction)

        present(sheetyColors, animated: true, completion: nil)
    }
}
