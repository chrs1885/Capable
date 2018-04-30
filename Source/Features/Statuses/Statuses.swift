//
//  Statuses.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

import Foundation

class Statuses: StatusesProtocol {
    var features: [CapableFeature]
    
    required convenience init() {
        self.init(with: CapableFeature.allValues())
    }
    
    required init(with features: [CapableFeature]) {
        self.features = features
    }
    
    var isAssistiveTouchEnabled: Bool {
        get {
            return UIAccessibilityIsAssistiveTouchRunning()
        }
    }
    
    var isBoldTextEnabled: Bool {
        get {
            return UIAccessibilityIsBoldTextEnabled()
        }
    }
    
    var isClosedCaptioningEnabled: Bool {
        get {
            return UIAccessibilityIsClosedCaptioningEnabled()
        }
    }
    
    var isDarkerSystemColorsEnabled: Bool {
        get {
            return UIAccessibilityDarkerSystemColorsEnabled()
        }
    }
    
    var isGrayscaleEnabled: Bool {
        get {
            return UIAccessibilityIsGrayscaleEnabled()
        }
    }
    
    var isGuidedAccessEnabled: Bool {
        get {
            return UIAccessibilityIsGuidedAccessEnabled()
        }
    }
    
    var isInvertColorsEnabled: Bool {
        get {
            return UIAccessibilityIsInvertColorsEnabled()
        }
    }
    
    var largerTextCatagory: UIContentSizeCategory {
        get {
            return UIScreen.main.traitCollection.preferredContentSizeCategory
        }
    }
    
    var isMonoAudioEnabled: Bool {
        get {
            return UIAccessibilityIsSpeakScreenEnabled()
        }
    }
    
    var isShakeToUndoEnabled: Bool {
        get {
            return UIAccessibilityIsShakeToUndoEnabled()
        }
    }
    
    var isSpeakScreenEnabled: Bool {
        get {
            return UIAccessibilityIsSpeakScreenEnabled()
        }
    }
    
    var isSpeakSelectionEnabled: Bool {
        get {
            return UIAccessibilityIsSpeakSelectionEnabled()
        }
    }
    
    var isSwitchControlEnabled: Bool {
        get {
            return UIAccessibilityIsSwitchControlRunning()
        }
    }
    
    var isReduceMotionEnabled: Bool {
        get {
            return UIAccessibilityIsReduceMotionEnabled()
        }
    }
    
    var isReduceTransparencyEnabled: Bool {
        get {
            return UIAccessibilityIsReduceTransparencyEnabled()
        }
    }
    
    var isVoiceOverEnabled: Bool {
        get {
            return UIAccessibilityIsVoiceOverRunning()
        }
    }
}

// MARK: Statuses
extension Statuses {
    var statusMap: [CapableFeature: String] {
        get {
            var featuresStatusMap = [CapableFeature: String]()
            if (self.features.contains(.AssistiveTouch)) {
                featuresStatusMap[.AssistiveTouch] = self.isAssistiveTouchEnabled.statusString
            }
            if (self.features.contains(.BoldText)) {
                featuresStatusMap[.BoldText] = self.isBoldTextEnabled.statusString
            }
            if (self.features.contains(.ClosedCaptioning)) {
                featuresStatusMap[.ClosedCaptioning] = self.isClosedCaptioningEnabled.statusString
            }
            if (self.features.contains(.DarkerSystemColors)) {
                featuresStatusMap[.DarkerSystemColors] = self.isDarkerSystemColorsEnabled.statusString
            }
            if (self.features.contains(.Grayscale)) {
                featuresStatusMap[.Grayscale] = self.isGrayscaleEnabled.statusString
            }
            if (self.features.contains(.GuidedAccess)) {
                featuresStatusMap[.GuidedAccess] = self.isGuidedAccessEnabled.statusString
            }
            if (self.features.contains(.InvertColors)) {
                featuresStatusMap[.InvertColors] = self.isInvertColorsEnabled.statusString
            }
            if (self.features.contains(.LargerText)) {
                featuresStatusMap[.LargerText] = self.largerTextCatagory.stringValue
            }
            if (self.features.contains(.MonoAudio)) {
                featuresStatusMap[.MonoAudio] = self.isMonoAudioEnabled.statusString
            }
            if (self.features.contains(.ShakeToUndo)) {
                featuresStatusMap[.ShakeToUndo] = self.isShakeToUndoEnabled.statusString
            }
            if (self.features.contains(.SpeakScreen)) {
                featuresStatusMap[.SpeakScreen] = self.isSpeakScreenEnabled.statusString
            }
            if (self.features.contains(.SpeakSelection)) {
                featuresStatusMap[.SpeakSelection] = self.isSpeakSelectionEnabled.statusString
            }
            if (self.features.contains(.SwitchControl)) {
                featuresStatusMap[.SwitchControl] = self.isSwitchControlEnabled.statusString
            }
            if (self.features.contains(.ReduceMotion)) {
                featuresStatusMap[.ReduceMotion] = self.isReduceMotionEnabled.statusString
            }
            if (self.features.contains(.ReduceTransparency)) {
                featuresStatusMap[.ReduceTransparency] = self.isReduceTransparencyEnabled.statusString
            }
            if (self.features.contains(.VoiceOver)) {
                featuresStatusMap[.VoiceOver] = self.isVoiceOverEnabled.statusString
            }
            return featuresStatusMap
        }
    }
    
    func isFeatureEnable(feature: CapableFeature) -> Bool {
        switch feature {
        case .AssistiveTouch:
            return self.isAssistiveTouchEnabled
        case .BoldText:
            return self.isBoldTextEnabled
        case .ClosedCaptioning:
            return self.isClosedCaptioningEnabled
        case .DarkerSystemColors:
            return self.isDarkerSystemColorsEnabled
        case .Grayscale:
            return self.isGrayscaleEnabled
        case .GuidedAccess:
            return self.isGuidedAccessEnabled
        case .InvertColors:
            return self.isInvertColorsEnabled
        case .LargerText:
            return !(self.largerTextCatagory == .medium)
        case .MonoAudio:
            return self.isMonoAudioEnabled
        case .ShakeToUndo:
            return self.isShakeToUndoEnabled
        case .SpeakScreen:
            return self.isSpeakScreenEnabled
        case .SpeakSelection:
            return self.isSpeakSelectionEnabled
        case .SwitchControl:
            return self.isSwitchControlEnabled
        case .ReduceMotion:
            return self.isReduceMotionEnabled
        case .ReduceTransparency:
            return self.isReduceTransparencyEnabled
        case .VoiceOver:
            return self.isVoiceOverEnabled
        }
    }
}

