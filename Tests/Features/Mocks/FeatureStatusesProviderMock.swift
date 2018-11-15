//
//  FeatureStatusesProviderMock.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 16.08.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

@testable import Capable

#if os(iOS)
import UIKit
#endif

class FeatureStatusesProviderMock: FeatureStatusesProvider {
    var didCallIsFeatureEnabled = false

    #if os(iOS)
    var assistiveTouchEnabled = false
    var darkerSystemColorsEnabled = false
    var textCatagory: UIContentSizeCategory = .unspecified
    var guidedAccessEnabled = false
    var hearingDeviceEar: UIAccessibility.HearingDeviceEar = UIAccessibility.HearingDeviceEar(rawValue: 0)
    var shakeToUndoEnabled = false
    var speakScreenEnabled = false
    var speakSelectionEnabled = false
    #endif

    #if os(OSX)
    var differentiateWithoutColor = false
    var fullKeyboardAccess = false
    var increaseContrast = false
    #endif

    #if os(iOS) || os(tvOS)
    var boldTextEnabled = false
    var closedCaptioningEnabled = false
    var grayscaleEnabled = false
    var monoAudioEnabled = false
    #endif

    var invertColorsEnabled = false
    var reduceMotionEnabled = false
    var reduceTransparencyEnabled = false
    var switchControlEnabled = false
    var voiceOverEnabled = false

    #if os(iOS)
    override var isAssistiveTouchEnabled: Bool {
        return assistiveTouchEnabled
    }

    override var isDarkerSystemColorsEnabled: Bool {
        return darkerSystemColorsEnabled
    }

    override var hearingDevicePairedEar: UIAccessibility.HearingDeviceEar {
        return self.hearingDeviceEar
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

    override var isFullKeyboardAccessEnabled: Bool {
        return fullKeyboardAccess
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

    func enableAllFeatures() {
        #if os(iOS)
        assistiveTouchEnabled = true
        darkerSystemColorsEnabled = true
        textCatagory = .accessibilityExtraExtraExtraLarge
        guidedAccessEnabled = true
        shakeToUndoEnabled = true
        speakScreenEnabled = true
        speakSelectionEnabled = true
        self.hearingDeviceEar = .both
        #endif

        #if os(OSX)
        differentiateWithoutColor = true
        fullKeyboardAccess = true
        increaseContrast = true
        #endif

        #if os(iOS) || os(tvOS)
        boldTextEnabled = true
        closedCaptioningEnabled = true
        grayscaleEnabled = true
        monoAudioEnabled = true
        #endif

        invertColorsEnabled = true
        reduceMotionEnabled = true
        reduceTransparencyEnabled = true
        switchControlEnabled = true
        voiceOverEnabled = true
    }

    override func isFeatureEnabled(feature: CapableFeature) -> Bool {
        didCallIsFeatureEnabled = true
        return super.isFeatureEnabled(feature: feature)
    }
}

#endif
