//
//  CGFloat+ContentSizeCategoryString.swift
//  Capable
//
//  Created by Christoph Wendt on 06.07.18.
//

#if os(watchOS) || os(tvOS)
extension CGFloat {
    var contentSizeString: String {
        get {
            switch(self){
            case 14.0:
                return "XS"
            case 15.0:
                return "S"
            case 16.0:
                return "L"
            case 17.0:
                return "XL"
            case 18.0:
                return "XXL"
            case 19.0:
                return "XXXL"
            default:
                return "Unknown"
            }
        }
    }
}
#endif
