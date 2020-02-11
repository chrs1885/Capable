//
//  ImageArea.swift
//  Capable
//
//  Created by Wendt, Christoph on 18.09.19.
//

#if os(iOS) || os(tvOS) || os(OSX)

    import CoreGraphics

    public enum ImageArea {
        /// The full image size.
        case full

        /// The last vertical third.
        case bottom

        /// The second horizontal third of the last vertical third.
        case bottomCenter

        /// The first horizontal third of the last vertical third.
        case bottomLeft

        /// The last horizontal third of the last vertical third.
        case bottomRight

        /// The second horizontal third of the second vertical third.
        case center

        /// The first horizontal third of the second vertical third.
        case centerLeft

        /// The last horizontal third of the second vertical third.
        case centerRight

        /// A custom area of the image defined by a CGRect.
        case custom(rect: CGRect)

        /// The second vertical third.
        case horizontalCenter

        /// The first horizontal third.
        case left

        /// The last horizontal third.
        case right

        /// The first vertical third.
        case top

        /// The second horizontal third of the first vertical third.
        case topCenter

        /// The first horizontal third of the first vertical third.
        case topLeft

        /// The last horizontal third of the first vertical third.
        case topRight

        /// The second horizontal third.
        case verticalCenter

        func rect(forImage image: TypeImage) -> CGRect {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            let widthThird = imageWidth / 3.0
            let heightThird = imageHeight / 3.0

            switch self {
            case .bottom:
                return CGRect(x: 0, y: heightThird * 2, width: imageWidth, height: heightThird)
            case .bottomCenter:
                return CGRect(x: widthThird, y: heightThird * 2, width: widthThird, height: heightThird)
            case .bottomLeft:
                return CGRect(x: 0, y: heightThird * 2, width: widthThird, height: heightThird)
            case .bottomRight:
                return CGRect(x: widthThird * 2, y: heightThird * 2, width: widthThird, height: heightThird)
            case .center:
                return CGRect(x: widthThird, y: heightThird, width: widthThird, height: heightThird)
            case .centerLeft:
                return CGRect(x: 0, y: heightThird, width: widthThird, height: heightThird)
            case .centerRight:
                return CGRect(x: widthThird * 2, y: heightThird, width: widthThird, height: heightThird)
            case let .custom(rect):
                return rect
            case .full:
                return CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            case .horizontalCenter:
                return CGRect(x: 0, y: heightThird, width: imageWidth, height: heightThird)
            case .left:
                return CGRect(x: 0, y: 0, width: widthThird, height: imageHeight)
            case .right:
                return CGRect(x: widthThird * 2, y: 0, width: widthThird, height: imageHeight)
            case .top:
                return CGRect(x: 0, y: 0, width: imageWidth, height: heightThird)
            case .topCenter:
                return CGRect(x: widthThird, y: 0, width: widthThird, height: heightThird)
            case .topLeft:
                return CGRect(x: 0, y: 0, width: widthThird, height: heightThird)
            case .topRight:
                return CGRect(x: widthThird * 2, y: 0, width: widthThird, height: heightThird)
            case .verticalCenter:
                return CGRect(x: widthThird, y: 0, width: widthThird, height: imageHeight)
            }
        }
    }

#endif
