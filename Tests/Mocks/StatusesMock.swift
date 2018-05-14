//
//  StatusesMock.swift
//  Capable
//
//  Created by Christoph Wendt on 18.04.18.
//
#if os(iOS) || os(tvOS)
import Foundation

class StatusesMock: Statuses {
    
    var assistiveTouchEnabled: Bool = false;
    var boldTextEnabled: Bool = false;
    var closedCaptioningEnabled: Bool = false;
    var darkerSystemColorsEnabled: Bool = false;
    var grayscaleEnabled: Bool = false;
    var guidedAccessEnabled: Bool = false;
    var invertColorsEnabled: Bool = false;
    var textCatagory: UIContentSizeCategory = .unspecified;
    var monoAudioEnabled: Bool = false;
    var reduceMotionEnabled: Bool = false;
    var reduceTransparencyEnabled: Bool = false;
    var shakeToUndoEnabled: Bool = false;
    var speakScreenEnabled: Bool = false;
    var speakSelectionEnabled: Bool = false;
    var switchControlEnabled: Bool = false;
    var voiceOverEnabled: Bool = false;
    
    required convenience init() {
        self.init(with: CapableFeature.allValues())
    }
    
    required init(with features: [CapableFeature]) {
        super.init(with: features)
    }
    
    override var isAssistiveTouchEnabled: Bool {
        get {
            return assistiveTouchEnabled
        }
    }
    
    override var isBoldTextEnabled: Bool {
        get {
            return boldTextEnabled
        }
    }
    
    override var isClosedCaptioningEnabled: Bool {
        get {
            return closedCaptioningEnabled
        }
    }
    
    override var isDarkerSystemColorsEnabled: Bool {
        get {
            return darkerSystemColorsEnabled
        }
    }
    
    override var isGrayscaleEnabled: Bool {
        get {
            return grayscaleEnabled
        }
    }
    
    override var isGuidedAccessEnabled: Bool {
        get {
            return guidedAccessEnabled
        }
    }
    
    override var isInvertColorsEnabled: Bool {
        get {
            return invertColorsEnabled
        }
    }
    
    override var largerTextCatagory: UIContentSizeCategory {
        get {
            return textCatagory
        }
    }
    
    override var isMonoAudioEnabled: Bool {
        get {
            return monoAudioEnabled
        }
    }
    
    override var isReduceMotionEnabled: Bool {
        get {
            return reduceMotionEnabled
        }
    }
    
    override var isReduceTransparencyEnabled: Bool {
        get {
            return reduceTransparencyEnabled
        }
    }
    
    override var isShakeToUndoEnabled: Bool {
        get {
            return shakeToUndoEnabled
        }
    }
    
    override var isSpeakScreenEnabled: Bool {
        get {
            return speakScreenEnabled
        }
    }
    
    override var isSpeakSelectionEnabled: Bool {
        get {
            return speakSelectionEnabled
        }
    }
    
    override var isSwitchControlEnabled: Bool {
        get {
            return switchControlEnabled
        }
    }
    
    override var isVoiceOverEnabled: Bool {
        get {
            return voiceOverEnabled
        }
    }
}
#endif
