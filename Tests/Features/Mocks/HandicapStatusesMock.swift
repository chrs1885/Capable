//
//  HandicapStatusesMock.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 16.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable

#if os(iOS)
import UIKit
#endif

class HandicapStatusesMock: HandicapStatuses {

    #if os(iOS)
    var assistiveTouchEnabled: Bool = false
    var darkerSystemColorsEnabled: Bool = false
    var textCatagory: UIContentSizeCategory = .unspecified
    var guidedAccessEnabled: Bool = false
    var shakeToUndoEnabled: Bool = false
    var speakScreenEnabled: Bool = false
    var speakSelectionEnabled: Bool = false
    #endif

    #if os(OSX)
    var differentiateWithoutColor: Bool = false
    var increaseContrast: Bool = false
    #endif

    #if os(iOS) || os(tvOS)
    var boldTextEnabled: Bool = false
    var closedCaptioningEnabled: Bool = false
    var grayscaleEnabled: Bool = false
    var monoAudioEnabled: Bool = false
    #endif

    var invertColorsEnabled: Bool = false
    var reduceMotionEnabled: Bool = false
    var reduceTransparencyEnabled: Bool = false
    var switchControlEnabled: Bool = false
    var voiceOverEnabled: Bool = false

    #if os(iOS)
    override var isAssistiveTouchEnabled: Bool {
        return assistiveTouchEnabled
    }

    override var isDarkerSystemColorsEnabled: Bool {
        return darkerSystemColorsEnabled
    }

    override var largerTextCatagory: UIContentSizeCategory {
        return textCatagory
    }

    override var isGuidedAccessEnabled: Bool {
        return guidedAccessEnabled
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
    #endif

    #if os(OSX)
    override var isDifferentiateWithoutColorEnabled: Bool {
        return differentiateWithoutColor
    }

    override var isIncreaseContrastEnabled: Bool {
        return increaseContrast
    }
    #endif

    #if os(iOS) || os(tvOS)
    override var isBoldTextEnabled: Bool {
        return boldTextEnabled
    }

    override var isClosedCaptioningEnabled: Bool {
        return closedCaptioningEnabled
    }

    override var isGrayscaleEnabled: Bool {
        return grayscaleEnabled
    }

    override var isMonoAudioEnabled: Bool {
        return monoAudioEnabled
    }
    #endif

    override var isInvertColorsEnabled: Bool {
        return invertColorsEnabled
    }

    override var isReduceMotionEnabled: Bool {
        return reduceMotionEnabled
    }

    override var isReduceTransparencyEnabled: Bool {
        return reduceTransparencyEnabled
    }

    override var isSwitchControlEnabled: Bool {
        return switchControlEnabled
    }

    override var isVoiceOverEnabled: Bool {
        return voiceOverEnabled
    }
}

#endif
