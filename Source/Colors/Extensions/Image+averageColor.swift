//
//  Image+averageColor.swift
//  Capable
//
//  Created by Christoph Wendt on 18.09.19.
//

import CoreGraphics

#if os(iOS) || os(tvOS)

    import UIKit

    /// Typealias used for images. It maps to UIImage.
    public typealias TypeImage = UIImage

#elseif os(OSX)

    import AppKit

    /// Typealias used for image. It maps to NSImage.
    public typealias TypeImage = NSImage

#endif

#if os(iOS) || os(tvOS) || os(OSX)

    extension TypeImage {
        func averageColor(imageArea: ImageArea = .full) -> TypeColor? {
            let imageAreaRect = imageArea.rect(forImage: self)
            var transform = CGAffineTransform(scaleX: 1, y: -1)
            transform = transform.translatedBy(x: 0, y: -size.height)
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
        func averageColor(in rect: CGRect) -> TypeColor? {
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
            let averageColor = TypeColor(
                red: CGFloat(bitmap[0]) / 255,
                green: CGFloat(bitmap[1]) / 255,
                blue: CGFloat(bitmap[2]) / 255,
                alpha: CGFloat(bitmap[3]) / 255
            )

            return averageColor
        }
    }

#endif
