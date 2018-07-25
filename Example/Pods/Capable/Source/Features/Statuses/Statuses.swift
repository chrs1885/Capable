//
//  Statuses.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

import Foundation
#if os(watchOS)
import WatchKit
#endif

class Statuses: StatusesProtocol {
    var features: [CapableFeature]
    
    required convenience init() {
        self.init(with: CapableFeature.allValues())
    }
    
    required init(with features: [CapableFeature]) {
        self.features = features
    }

    var statusMap: [String: String] {
        get {
            var featuresStatusMap = [String: String]()
            
            #if os(iOS)
                if (self.features.contains(.AssistiveTouch)) {
                    featuresStatusMap[CapableFeature.AssistiveTouch.rawValue] = self.isAssistiveTouchEnabled.statusString
                }
                if (self.features.contains(.DarkerSystemColors)) {
                    featuresStatusMap[CapableFeature.DarkerSystemColors.rawValue] = self.isDarkerSystemColorsEnabled.statusString
                }
                if (self.features.contains(.GuidedAccess)) {
                    featuresStatusMap[CapableFeature.GuidedAccess.rawValue] = self.isGuidedAccessEnabled.statusString
                }
                if (self.features.contains(.InvertColors)) {
                    featuresStatusMap[CapableFeature.InvertColors.rawValue] = self.isInvertColorsEnabled.statusString
                }
                if (self.features.contains(.LargerText)) {
                    featuresStatusMap[CapableFeature.LargerText.rawValue] = self.largerTextCatagory.stringValue
                }
                if (self.features.contains(.ShakeToUndo)) {
                    featuresStatusMap[CapableFeature.ShakeToUndo.rawValue] = self.isShakeToUndoEnabled.statusString
                }
                if (self.features.contains(.SpeakScreen)) {
                    featuresStatusMap[CapableFeature.SpeakScreen.rawValue] = self.isSpeakScreenEnabled.statusString
                }
                if (self.features.contains(.SpeakSelection)) {
                    featuresStatusMap[CapableFeature.SpeakSelection.rawValue] = self.isSpeakSelectionEnabled.statusString
                }
            #endif
            
            #if os(iOS) || os(tvOS)
                if (self.features.contains(.BoldText)) {
                    featuresStatusMap[CapableFeature.BoldText.rawValue] = self.isBoldTextEnabled.statusString
                }
                if (self.features.contains(.ClosedCaptioning)) {
                    featuresStatusMap[CapableFeature.ClosedCaptioning.rawValue] = self.isClosedCaptioningEnabled.statusString
                }
                if (self.features.contains(.Grayscale)) {
                    featuresStatusMap[CapableFeature.Grayscale.rawValue] = self.isGrayscaleEnabled.statusString
                }
                if (self.features.contains(.MonoAudio)) {
                    featuresStatusMap[CapableFeature.MonoAudio.rawValue] = self.isMonoAudioEnabled.statusString
                }
                if (self.features.contains(.ReduceTransparency)) {
                    featuresStatusMap[CapableFeature.ReduceTransparency.rawValue] = self.isReduceTransparencyEnabled.statusString
                }
                if (self.features.contains(.SwitchControl)) {
                    featuresStatusMap[CapableFeature.SwitchControl.rawValue] = self.isSwitchControlEnabled.statusString
                }
            #endif
            
            if (self.features.contains(.ReduceMotion)) {
                featuresStatusMap[CapableFeature.ReduceMotion.rawValue] = self.isReduceMotionEnabled.statusString
            }
            if (self.features.contains(.VoiceOver)) {
                featuresStatusMap[CapableFeature.VoiceOver.rawValue] = self.isVoiceOverEnabled.statusString
            }
            return featuresStatusMap
        }
    }
    
    #if os(iOS) || os(tvOS)
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
    
    var isReduceTransparencyEnabled: Bool {
        get {
            return UIAccessibilityIsReduceTransparencyEnabled()
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
    #endif
    
    var isReduceMotionEnabled: Bool {
        get {
            #if os(watchOS)
                if #available(watchOS 4.0, *) {
                    return WKAccessibilityIsReduceMotionEnabled()
                } else {
                    return false
                }
            #else
                return UIAccessibilityIsReduceMotionEnabled()
            #endif
        }
    }
    
    var isVoiceOverEnabled: Bool {
        get {
            #if os(watchOS)
                return WKAccessibilityIsVoiceOverRunning()
            #else
                return UIAccessibilityIsVoiceOverRunning()
            #endif
        }
    }
    
    func isFeatureEnable(feature: CapableFeature) -> Bool {
        #if os(iOS)
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
        #elseif os(tvOS)
        switch feature {
        case .BoldText:
            return self.isBoldTextEnabled
        case .ClosedCaptioning:
            return self.isClosedCaptioningEnabled
        case .Grayscale:
            return self.isGrayscaleEnabled
        case .MonoAudio:
            return self.isMonoAudioEnabled
        case .SwitchControl:
            return self.isSwitchControlEnabled
        case .ReduceMotion:
            return self.isReduceMotionEnabled
        case .ReduceTransparency:
            return self.isReduceTransparencyEnabled
        case .VoiceOver:
            return self.isVoiceOverEnabled
        }
        #elseif os(watchOS)
        switch feature {
        case .ReduceMotion:
            return self.isReduceMotionEnabled
        case .VoiceOver:
            return self.isVoiceOverEnabled
        }
        #endif
    }
}
