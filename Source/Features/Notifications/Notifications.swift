//
//  Notifications.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

import Foundation
#if os(watchOS)
    import WatchKit
#endif

class Notifications: NotificationsProtocol {
    var statusesModule: StatusesProtocol
    
    required init(statusesModule: StatusesProtocol) {
        self.statusesModule = statusesModule
    }
}

// MARK: Register Observers
extension Notifications {
   func enableNotifications(for features: [CapableFeature]) {
        #if os(iOS)
            if features.contains(.AssistiveTouch) {
                addObserver(for: .UIAccessibilityAssistiveTouchStatusDidChange, selector: #selector(self.assistiveTouchStatusChanged))
            }
            if features.contains(.DarkerSystemColors) {
                addObserver(for: .UIAccessibilityDarkerSystemColorsStatusDidChange, selector: #selector(self.darkerSystemColorsStatusChanged))
            }
            if features.contains(.GuidedAccess) {
                addObserver(for: .UIAccessibilityGuidedAccessStatusDidChange, selector: #selector(self.guidedAccessStatusChanged))
            }
            if features.contains(.InvertColors) {
                addObserver(for: .UIAccessibilityInvertColorsStatusDidChange, selector: #selector(self.invertColorsStatusChanged))
            }
            if features.contains(.LargerText) {
                addObserver(for: .UIContentSizeCategoryDidChange, selector: #selector(self.largerTextStatusChanged))
            }
            if features.contains(.ShakeToUndo) {
                addObserver(for: .UIAccessibilityShakeToUndoDidChange, selector: #selector(self.shakeToUndoStatusChanged))
            }
            if features.contains(.SpeakScreen) {
                addObserver(for: .UIAccessibilitySpeakScreenStatusDidChange, selector: #selector(self.speakScreenStatusChanged))
            }
            if features.contains(.SpeakSelection) {
                addObserver(for: .UIAccessibilitySpeakSelectionStatusDidChange, selector: #selector(self.speakSelectionStatusChanged))
            }
        #endif
    
        #if os(iOS) || os(tvOS)
            if features.contains(.BoldText) {
                addObserver(for: .UIAccessibilityBoldTextStatusDidChange, selector: #selector(self.boldTextStatusChanged))
            }
            if features.contains(.ClosedCaptioning) {
                addObserver(for: .UIAccessibilityClosedCaptioningStatusDidChange, selector: #selector(self.closedCaptioningStatusChanged))
            }
            if features.contains(.Grayscale) {
                addObserver(for: .UIAccessibilityGrayscaleStatusDidChange, selector: #selector(self.grayscaleStatusChanged))
            }
            if features.contains(.MonoAudio) {
                addObserver(for: .UIAccessibilityMonoAudioStatusDidChange, selector: #selector(self.monoAudioStatusChanged))
            }
            if features.contains(.SwitchControl) {
                addObserver(for: .UIAccessibilitySwitchControlStatusDidChange, selector: #selector(self.switchControlStatusChanged))
            }
            if features.contains(.ReduceMotion) {
                addObserver(for: .UIAccessibilityReduceMotionStatusDidChange, selector: #selector(self.reduceMotionStatusChanged))
            }
            if features.contains(.ReduceTransparency) {
                addObserver(for: .UIAccessibilityReduceTransparencyStatusDidChange, selector: #selector(self.reduceTransparencyStatusChanged))
            }
            if features.contains(.VoiceOver) {
                if #available(iOS 11.0, tvOS 11.0, *) {
                    addObserver(for: .UIAccessibilityVoiceOverStatusDidChange, selector: #selector(self.voiceOverStatusChanged))
                } else {
                    addObserver(for: Notification.Name(UIAccessibilityVoiceOverStatusChanged), selector: #selector(self.voiceOverStatusChanged))
                }
            }
        #endif
    
        #if os(watchOS)
            if #available(watchOS 4.0, *), features.contains(.ReduceMotion) {
                addObserver(for: .WKAccessibilityReduceMotionStatusDidChange, selector: #selector(self.reduceMotionStatusChanged))
            }
            if features.contains(.VoiceOver) {
                addObserver(for: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged), selector: #selector(self.voiceOverStatusChanged))
            }
        #endif
    }
}

// MARK: Handle notifications
extension Notifications {
    func addObserver(for notificationName: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: notificationName,
            object: nil)
    }
    
    func disableNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    #if os(iOS)
    @objc func assistiveTouchStatusChanged(notification: NSNotification) {
        postNotification(with: .AssistiveTouch, statusString: self.statusesModule.isAssistiveTouchEnabled.statusString)
    }
    
    @objc func darkerSystemColorsStatusChanged(notification: NSNotification) {
        self.postNotification(with: .DarkerSystemColors, statusString: self.statusesModule.isDarkerSystemColorsEnabled.statusString)
    }
    
    @objc func guidedAccessStatusChanged(notification: NSNotification) {
        self.postNotification(with: .GuidedAccess, statusString: self.statusesModule.isGuidedAccessEnabled.statusString)
    }
    
    @objc func invertColorsStatusChanged(notification: NSNotification) {
        self.postNotification(with: .InvertColors, statusString: self.statusesModule.isInvertColorsEnabled.statusString)
    }
    
    @objc func largerTextStatusChanged(notification: NSNotification) {
        self.postNotification(with: .LargerText, statusString: self.statusesModule.largerTextCatagory.stringValue)
    }
    
    @objc func shakeToUndoStatusChanged(notification: NSNotification) {
        self.postNotification(with: .ShakeToUndo, statusString: self.statusesModule.isShakeToUndoEnabled.statusString)
    }
    
    @objc func speakScreenStatusChanged(notification: NSNotification) {
        self.postNotification(with: .SpeakScreen, statusString: self.statusesModule.isSpeakScreenEnabled.statusString)
    }
    
    @objc func speakSelectionStatusChanged(notification: NSNotification) {
        self.postNotification(with: .SpeakSelection, statusString: self.statusesModule.isSpeakSelectionEnabled.statusString)
    }
    #endif
    
    #if os(iOS) || os(tvOS)
    @objc func boldTextStatusChanged(notification: NSNotification) {
        self.postNotification(with: .BoldText, statusString: self.statusesModule.isBoldTextEnabled.statusString)
    }
    
    @objc func closedCaptioningStatusChanged(notification: NSNotification) {
        self.postNotification(with: .ClosedCaptioning, statusString: self.statusesModule.isClosedCaptioningEnabled.statusString)
    }
    
    @objc func grayscaleStatusChanged(notification: NSNotification) {
        self.postNotification(with: .Grayscale, statusString: self.statusesModule.isGrayscaleEnabled.statusString)
    }
    
    @objc func monoAudioStatusChanged(notification: NSNotification) {
        self.postNotification(with: .MonoAudio, statusString: self.statusesModule.isMonoAudioEnabled.statusString)
    }
    
    @objc func switchControlStatusChanged(notification: NSNotification) {
        self.postNotification(with: .SwitchControl, statusString: self.statusesModule.isSwitchControlEnabled.statusString)
    }
    
    @objc func reduceTransparencyStatusChanged(notification: NSNotification) {
        self.postNotification(with: .ReduceTransparency, statusString: self.statusesModule.isReduceTransparencyEnabled.statusString)
    }
    #endif

    @objc func reduceMotionStatusChanged(notification: NSNotification) {
        self.postNotification(with: .ReduceMotion, statusString: self.statusesModule.isReduceMotionEnabled.statusString)
    }
    
    @objc private func voiceOverStatusChanged(notification: NSNotification) {
        self.postNotification(with: .VoiceOver, statusString: self.statusesModule.isVoiceOverEnabled.statusString)
    }
}

// MARK: Post notifications
extension Notifications {
    func postNotification(with feature: CapableFeature, statusString: String) {
        let featureStatus = FeatureStatus(with: feature, statusString: statusString)
        NotificationCenter.default.post(name: .CapableFeatureStatusDidChange, object: featureStatus)
    }
}
