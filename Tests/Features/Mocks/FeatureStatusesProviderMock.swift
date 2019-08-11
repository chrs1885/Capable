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
    var guidedAccessEnabled = false
    var hearingDeviceEar: UIAccessibility.HearingDeviceEar = UIAccessibility.HearingDeviceEar(rawValue: 0)
    var onOffSwitchLabelsEnabled = false
    var shakeToUndoEnabled = false
    var speakScreenEnabled = false
    var speakSelectionEnabled = false
    var textCatagory: UIContentSizeCategory = .unspecified
    #endif

    #if os(OSX)
    var fullKeyboardAccess = false
    var increaseContrast = false
    #endif

    #if os(iOS) || os(tvOS)
    var boldTextEnabled = false
    var closedCaptioningEnabled = false
    var grayscaleEnabled = false
    var monoAudioEnabled = false
    var videoAutoplayEnabled = false
    #endif

    #if os(iOS) || os(OSX)
    var differentiateWithoutColor = false
    #endif

    var invertColorsEnabled = false
    var reduceMotionEnabled = false
    var reduceTransparencyEnabled = false
    var switchControlEnabled = false
    var voiceOverEnabled = false

    #if os(iOS)

    override var isAssistiveTouchEnabled: Bool {
        return self.assistiveTouchEnabled
    }

    override var isDarkerSystemColorsEnabled: Bool {
        return self.darkerSystemColorsEnabled
    }

    override var isGuidedAccessEnabled: Bool {
        return self.guidedAccessEnabled
    }

    override var hearingDevicePairedEar: UIAccessibility.HearingDeviceEar {
        return self.hearingDeviceEar
    }

    override var largerTextCatagory: UIContentSizeCategory {
        return self.textCatagory
    }

    override var isOnOffSwitchLabelsEnabled: Bool {
        return self.onOffSwitchLabelsEnabled
    }

    override var isShakeToUndoEnabled: Bool {
        return self.shakeToUndoEnabled
    }

    override var isSpeakScreenEnabled: Bool {
        return self.speakScreenEnabled
    }

    override var isSpeakSelectionEnabled: Bool {
        return self.speakSelectionEnabled
    }

    #endif

    #if os(OSX)

    override var isFullKeyboardAccessEnabled: Bool {
        return self.fullKeyboardAccess
    }

    override var isIncreaseContrastEnabled: Bool {
        return self.increaseContrast
    }

    #endif

    #if os(iOS) || os(tvOS)

    override var isBoldTextEnabled: Bool {
        return self.boldTextEnabled
    }

    override var isClosedCaptioningEnabled: Bool {
        return self.closedCaptioningEnabled
    }

    override var isGrayscaleEnabled: Bool {
        return self.grayscaleEnabled
    }

    override var isMonoAudioEnabled: Bool {
        return self.monoAudioEnabled
    }

    override var isVideoAutoplayEnabled: Bool {
        return self.videoAutoplayEnabled
    }

    #endif

    #if os(iOS) || os(OSX)

    override var isDifferentiateWithoutColorEnabled: Bool {
        return self.differentiateWithoutColor
    }

    #endif

    override var isInvertColorsEnabled: Bool {
        return self.invertColorsEnabled
    }

    override var isReduceMotionEnabled: Bool {
        return self.reduceMotionEnabled
    }

    override var isReduceTransparencyEnabled: Bool {
        return self.reduceTransparencyEnabled
    }

    override var isSwitchControlEnabled: Bool {
        return self.switchControlEnabled
    }

    override var isVoiceOverEnabled: Bool {
        return self.voiceOverEnabled
    }

    func enableAllFeatures() {

        #if os(iOS)

        self.assistiveTouchEnabled = true
        self.darkerSystemColorsEnabled = true
        self.textCatagory = .accessibilityExtraExtraExtraLarge
        self.guidedAccessEnabled = true
        self.hearingDeviceEar = .both
        self.onOffSwitchLabelsEnabled = true
        self.shakeToUndoEnabled = true
        self.speakScreenEnabled = true
        self.speakSelectionEnabled = true

        #endif

        #if os(OSX)

        self.fullKeyboardAccess = true
        self.increaseContrast = true

        #endif

        #if os(iOS) || os(tvOS)

        self.boldTextEnabled = true
        self.closedCaptioningEnabled = true
        self.grayscaleEnabled = true
        self.monoAudioEnabled = true
        self.videoAutoplayEnabled = true

        #endif

        #if os(iOS) || os(OSX)

        self.differentiateWithoutColor = true

        #endif

        self.invertColorsEnabled = true
        self.reduceMotionEnabled = true
        self.reduceTransparencyEnabled = true
        self.switchControlEnabled = true
        self.voiceOverEnabled = true
    }

    override func isFeatureEnabled(feature: CapableFeature) -> Bool {
        didCallIsFeatureEnabled = true
        return super.isFeatureEnabled(feature: feature)
    }
}

#endif
