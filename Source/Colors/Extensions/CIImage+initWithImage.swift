//
//  CIImage+initWithImage.swift
//  Capable
//
//  Created by Wendt, Christoph on 28.09.19.
//

#if os(OSX)

    import AppKit

    extension CIImage {
        convenience init?(image: NSImage) {
            guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
                return nil
            }

            self.init(cgImage: cgImage)
        }
    }

#endif
