//
//  Image+averageColor.swift
//  Capable
//
//  Created by Christoph Wendt on 18.09.19.
//

import CoreGraphics

#if os(iOS) || os(tvOS)

import UIKit

public typealias Image = UIImage

#elseif os(OSX)

import AppKit

public typealias Image = NSImage

#endif

#if os(iOS) || os(tvOS) || os(OSX)

extension Image {
    func averageColor(imageArea: ImageArea = .full) -> Color? {
        let imageAreaRect = imageArea.rect(forImage: self)
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -self.size.height)
        let transformedRect = imageAreaRect.applying(transform)

        guard
            let inputImage = CIImage(image: self),
            let averageColor = inputImage.averageColor(in: transformedRect) else {
                return nil
        }

        return averageColor
    }
}

private extension CIImage {
    func averageColor(in rect: CGRect) -> Color? {
        let extentVector = CIVector(x: rect.origin.x, y: rect.origin.y, z: rect.size.width, w: rect.size.height)

        guard
            let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: self, kCIInputExtentKey: extentVector]),
            let imageSection = filter.outputImage else {
                Logger.warning("Unable to create image section.")
                return nil
        }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(imageSection, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        let averageColor = Color(
            red: CGFloat(bitmap[0]) / 255,
            green: CGFloat(bitmap[1]) / 255,
            blue: CGFloat(bitmap[2]) / 255,
            alpha: CGFloat(bitmap[3]) / 255
        )

        return averageColor
    }
}

#endif
