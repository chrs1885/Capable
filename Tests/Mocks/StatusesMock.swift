//
//  StatusesMock.swift
//  Capable
//
//  Created by Christoph Wendt on 18.04.18.
//
#if os(iOS) || os(tvOS)
import Foundation

class StatusesMock: Statuses {

    var assistiveTouchEnabled: Bool = false
    var boldTextEnabled: Bool = false
    var closedCaptioningEnabled: Bool = false
    var darkerSystemColorsEnabled: Bool = false
    var grayscaleEnabled: Bool = false
    var guidedAccessEnabled: Bool = false
    var invertColorsEnabled: Bool = false
    var textCatagory: UIContentSizeCategory = .unspecified
    var monoAudioEnabled: Bool = false
    var reduceMotionEnabled: Bool = false
    var reduceTransparencyEnabled: Bool = false
    var shakeToUndoEnabled: Bool = false
    var speakScreenEnabled: Bool = false
    var speakSelectionEnabled: Bool = false
    var switchControlEnabled: Bool = false
    var voiceOverEnabled: Bool = false

    required convenience init() {
        self.init(with: CapableFeature.allValues())
    }

    required init(with features: [CapableFeature]) {
        super.init(with: features)
    }

    override var isAssistiveTouchEnabled: Bool {
        return assistiveTouchEnabled
    }

    override var isBoldTextEnabled: Bool {
        return boldTextEnabled
    }

    override var isClosedCaptioningEnabled: Bool {
        return closedCaptioningEnabled
    }

    override var isDarkerSystemColorsEnabled: Bool {
        return darkerSystemColorsEnabled
    }

    override var isGrayscaleEnabled: Bool {
        return grayscaleEnabled
    }

    override var isGuidedAccessEnabled: Bool {
        return guidedAccessEnabled
    }

    override var isInvertColorsEnabled: Bool {
        return invertColorsEnabled
    }

    override var largerTextCatagory: UIContentSizeCategory {
        return textCatagory
    }

    override var isMonoAudioEnabled: Bool {
        return monoAudioEnabled
    }

    override var isReduceMotionEnabled: Bool {
        return reduceMotionEnabled
    }

    override var isReduceTransparencyEnabled: Bool {
        return reduceTransparencyEnabled
    }

    override var isShakeToUndoEnabled: Bool {
        return shakeToUndoEnabled
    }

    override var isSpeakScreenEnabled: Bool {
        return speakScreenEnabled
    }

    override var isSpeakSelectionEnabled: Bool {
        return speakSelectionEnabled
    }

    override var isSwitchControlEnabled: Bool {
        return switchControlEnabled
    }

    override var isVoiceOverEnabled: Bool {
        return voiceOverEnabled
    }
}
#endif
