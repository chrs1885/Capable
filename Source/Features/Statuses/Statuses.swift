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

public class Statuses: StatusesProtocol {
    public var features: [CapableFeature]
    
    public required convenience init() {
        self.init(with: CapableFeature.allValues())
    }
    
    public required init(with features: [CapableFeature]) {
        self.features = features
    }
}

// MARK: Statuses
extension Statuses {
    public var statusMap: [CapableFeature: String] {
        get {
            var featuresStatusMap = [CapableFeature: String]()
            
            #if os(iOS) || os(tvOS)
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
            if (self.features.contains(.ReduceTransparency)) {
                featuresStatusMap[.ReduceTransparency] = self.isReduceTransparencyEnabled.statusString
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
            #endif
            
            if (self.features.contains(.ReduceMotion)) {
                featuresStatusMap[.ReduceMotion] = self.isReduceMotionEnabled.statusString
            }
            if (self.features.contains(.VoiceOver)) {
                featuresStatusMap[.VoiceOver] = self.isVoiceOverEnabled.statusString
            }
            return featuresStatusMap
        }
    }
    
    #if os(iOS) || os(tvOS)
    public var isAssistiveTouchEnabled: Bool {
        get {
            return UIAccessibilityIsAssistiveTouchRunning()
        }
    }
    
    public var isBoldTextEnabled: Bool {
        get {
            return UIAccessibilityIsBoldTextEnabled()
        }
    }
    
    public var isClosedCaptioningEnabled: Bool {
        get {
            return UIAccessibilityIsClosedCaptioningEnabled()
        }
    }
    
    public var isDarkerSystemColorsEnabled: Bool {
        get {
            return UIAccessibilityDarkerSystemColorsEnabled()
        }
    }
    
    public var isGrayscaleEnabled: Bool {
        get {
            return UIAccessibilityIsGrayscaleEnabled()
        }
    }
    
    public var isGuidedAccessEnabled: Bool {
        get {
            return UIAccessibilityIsGuidedAccessEnabled()
        }
    }
    
    public var isInvertColorsEnabled: Bool {
        get {
            return UIAccessibilityIsInvertColorsEnabled()
        }
    }

    public var largerTextCatagory: UIContentSizeCategory {
        get {
            return UIScreen.main.traitCollection.preferredContentSizeCategory
        }
    }

    public var isMonoAudioEnabled: Bool {
        get {
            return UIAccessibilityIsSpeakScreenEnabled()
        }
    }
    
    public var isReduceTransparencyEnabled: Bool {
        get {
            return UIAccessibilityIsReduceTransparencyEnabled()
        }
    }

    public var isShakeToUndoEnabled: Bool {
        get {
            return UIAccessibilityIsShakeToUndoEnabled()
        }
    }

    public var isSpeakScreenEnabled: Bool {
        get {
            return UIAccessibilityIsSpeakScreenEnabled()
        }
    }

    public var isSpeakSelectionEnabled: Bool {
        get {
            return UIAccessibilityIsSpeakSelectionEnabled()
        }
    }

    public var isSwitchControlEnabled: Bool {
        get {
            return UIAccessibilityIsSwitchControlRunning()
        }
    }
    #endif
    
    public var isReduceMotionEnabled: Bool {
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
    
    public var isVoiceOverEnabled: Bool {
        get {
            #if os(watchOS)
                return WKAccessibilityIsVoiceOverRunning()
            #else
                return UIAccessibilityIsVoiceOverRunning()
            #endif
        }
    }
    
    public func isFeatureEnable(feature: CapableFeature) -> Bool {
        #if os(iOS) || os(tvOS)
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

