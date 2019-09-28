//
//  CaptionsViewController.swift
//  Example-iOS
//
//  Created by Wendt, Christoph on 21.09.19.
//  Copyright © 2019 Christoph Wendt. All rights reserved.
//

import UIKit
import Capable

class CaptionsViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topCenterLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var centerLeftLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var centerRightLabel: UILabel!
    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var bottomCenterLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!

    var isLoading: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.content.isHidden = self.isLoading

                if self.isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelColors()
    }

    private func setupLabelColors() {
        let backgroundImage = UIImage(named: "captions_gradient")!
        let labels: [UILabel:ImageArea] = [
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
                let textColor = UIColor.getTextColors(onBackgroundImage: backgroundImage, imageArea: label.value)

                DispatchQueue.main.async {
                    label.key.textColor = textColor
                }
            }
            self.isLoading = false
        }
    }
}
