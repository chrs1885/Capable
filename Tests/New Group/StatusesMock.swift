//
//  StatusesMock.swift
//  Capable
//
//  Created by Christoph Wendt on 18.04.18.
//

import Foundation

class StatusesMock: StatusesProtocol {
    
    var features: [CapableFeature] = [CapableFeature]()
    
    var statusMap: [CapableFeature : String] = [CapableFeature: String]()
    
    var isAssistiveTouchEnabled: Bool = false
    
    var isBoldTextEnabled: Bool = false
    
    var isClosedCaptioningEnabled: Bool = false
    
    var isDarkerSystemColorsEnabled: Bool = false
    
    var isGrayscaleEnabled: Bool = false
    
    var isGuidedAccessEnabled: Bool = false
    
    var isInvertColorsEnabled: Bool = false
    
    var largerTextCatagory: UIContentSizeCategory = UIContentSizeCategory.accessibilityMedium
    
    var isMonoAudioEnabled: Bool = false
    
    var isReduceMotionEnabled: Bool = false
    
    var isReduceTransparencyEnabled: Bool = false
    
    var isShakeToUndoEnabled: Bool = false
    
    var isSpeakScreenEnabled: Bool = false
    
    var isSpeakSelectionEnabled: Bool = false
    
    var isSwitchControlEnabled: Bool = false
    
    var isVoiceOverEnabled: Bool = false
    
    required init() {
    }
    
    required init(with features: [CapableFeature]) {
    }
    
    func isFeatureEnable(feature: CapableFeature) -> Bool {
        return false
    }
    
    
}
