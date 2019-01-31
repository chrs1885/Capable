//
//  ColorAlertController.swift
//  Example-iOS
//
//  Created by Christoph Wendt on 21.01.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import UIKit

enum ColorType: String {
    case textColor = "Text Color"
    case backgroundColor = "Background Color"
}

class ColorAlertController: UIAlertController {
    class func create(withColorType colorType: ColorType, color: UIColor, prefferedStyle: UIAlertController.Style, selectionHandler: @escaping (UIColor) -> ()) -> ColorAlertController {
        let colorPicker = ColorPickerView.fromNib() as ColorPickerView
        colorPicker.color = color
        colorPicker.alphaEnabled = colorType == .textColor
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.backgroundColor = nil
        colorPicker.addConstraint(NSLayoutConstraint(item: colorPicker,
                                                    attribute: .height,
                                                    relatedBy: .greaterThanOrEqual,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1,
                                                    constant: 400))

        let colorAlert = ColorAlertController(title: colorType.rawValue,
                                      customView: colorPicker,
                                      preferredStyle: .actionSheet)
        colorAlert.addAction(UIAlertAction(title: "Select", style: .default, handler: {
            _ in
            guard let selectedColor = colorPicker.color else { return }
            selectionHandler(selectedColor)
        }))
        colorAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        return colorAlert
    }
}

// MARK: - Custom View Support
private extension UIAlertController {
    convenience init(title: String?, customView: UIView, preferredStyle: UIAlertController.Style) {

        let marker = "__MARKER__"
        self.init(title: title, message: marker, preferredStyle: preferredStyle)
        if let customContentPlaceholder = self.view.findLabel(withText: marker),
            let customContainer =  customContentPlaceholder.superview {
            customContainer.addSubview(customView)

            customView.translatesAutoresizingMaskIntoConstraints = false
            customContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[customView]-|", options: [], metrics: nil, views: ["customView": customView]))
            customContainer.addConstraint(NSLayoutConstraint(item: customContentPlaceholder,
                                                             attribute: .top,
                                                             relatedBy: .equal,
                                                             toItem: customView,
                                                             attribute: .top,
                                                             multiplier: 1,
                                                             constant: 0))
            customContainer.addConstraint(NSLayoutConstraint(item: customContentPlaceholder,
                                                             attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: customView,
                                                             attribute: .height,
                                                             multiplier: 1,
                                                             constant: 0))
            customContentPlaceholder.text = ""
        }
    }
}

// MARK: - Search Views
private extension UIView {
    func findLabel(withText text: String) -> UILabel? {
        if let label = self as? UILabel, label.text == text {
            return label
        }

        for subview in self.subviews {
            if let found = subview.findLabel(withText: text) {
                return found
            }
        }

        return nil
    }
}

// MARK: - Loading XIB-Views
private extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
