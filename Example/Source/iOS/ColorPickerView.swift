//
//  ColorPickerView.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 22.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redColorLabel: UILabel!
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorLabel: UILabel!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorLabel: UILabel!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var alphaColorLabel: UILabel!
    @IBOutlet weak var alphaColorSlider: UISlider!

    var redValue: CGFloat = 0.0, greenValue: CGFloat = 0.0, blueValue: CGFloat = 0.0, alphaValue: CGFloat = 0.0

    var color: UIColor? {
        didSet {
            self.colorView.backgroundColor = self.color
        }

        willSet(newColor) {
            if let newColor = newColor, self.color == nil {
                var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
                newColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

                updateRed(withValue: red * 255)
                updateGreen(withValue: green * 255)
                updateBlue(withValue: blue * 255)
                updateAlpha(withValue: alpha * 100)
            }
        }
    }

    var alphaEnabled: Bool = true {
        didSet {
            self.alphaColorSlider.isEnabled = alphaEnabled
        }
    }
}

// MARK: - Updating Views
extension ColorPickerView {
    func updateRed(withValue value: CGFloat) {
        self.redValue = value
        self.redColorLabel.text = "Red: \(self.redValue)"
        self.redColorSlider.value = Float(self.redValue)
    }

    func updateGreen(withValue value: CGFloat) {
        self.greenValue = value
        self.greenColorLabel.text = "Green: \(self.greenValue)"
        self.greenColorSlider.value = Float(self.greenValue)
    }

    func updateBlue(withValue value: CGFloat) {
        self.blueValue = value
        self.blueColorLabel.text = "Blue: \(self.blueValue)"
        self.blueColorSlider.value = Float(self.blueValue)
    }

    func updateAlpha(withValue value: CGFloat) {
        self.alphaValue = value
        self.alphaColorLabel.text = "Alpha: \(self.alphaValue) %"
        self.alphaColorSlider.value = Float(self.alphaValue)
    }
}

// MARK: - Handling User Interaction
extension ColorPickerView {
    @IBAction func sliderValueChanged(_ sender: Any) {
        let slider = sender as! UISlider
        let value = CGFloat(floor(slider.value))

        if slider == self.redColorSlider {
            updateRed(withValue: value)
        } else if slider == self.greenColorSlider {
            updateGreen(withValue: value)
        } else if slider == self.blueColorSlider {
            updateBlue(withValue: value)
        } else if slider == self.alphaColorSlider {
            updateAlpha(withValue: value)
        }

        self.color = UIColor(red: self.redValue / 255.0, green: self.greenValue / 255.0, blue: self.blueValue / 255.0, alpha: self.alphaValue / 100.0)
    }
}
