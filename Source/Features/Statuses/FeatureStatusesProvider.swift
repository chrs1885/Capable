//
//  FeatureStatusesProvider.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(OSX)
import AppKit
#endif

#if os(watchOS)
import WatchKit
#endif

class FeatureStatusesProvider: FeatureStatusesProviderProtocol {

    #if os(iOS)

    var isAssistiveTouchEnabled: Bool {
        return UIAccessibility.isAssistiveTouchRunning
    }

    var isDarkerSystemColorsEnabled: Bool {
        return UIAccessibility.isDarkerSystemColorsEnabled
    }

    var isGuidedAccessEnabled: Bool {
        return UIAccessibility.isGuidedAccessEnabled
    }

    var hearingDevicePairedEar: UIAccessibility.HearingDeviceEar {
        return UIAccessibility.hearingDevicePairedEar
    }

    var largerTextCatagory: UIContentSizeCategory {
        return UIScreen.main.traitCollection.preferredContentSizeCategory
    }

    var isShakeToUndoEnabled: Bool {
        return UIAccessibility.isShakeToUndoEnabled
    }

    var isSpeakScreenEnabled: Bool {
        return UIAccessibility.isSpeakScreenEnabled
    }

    var isSpeakSelectionEnabled: Bool {
        return UIAccessibility.isSpeakSelectionEnabled
    }

    #endif

    #if os(iOS) || os(tvOS)

    var isBoldTextEnabled: Bool {
        return UIAccessibility.isBoldTextEnabled
    }

    var isClosedCaptioningEnabled: Bool {
        return UIAccessibility.isClosedCaptioningEnabled
    }

    var isGrayscaleEnabled: Bool {
        return UIAccessibility.isGrayscaleEnabled
    }

    var isInvertColorsEnabled: Bool {
        return UIAccessibility.isInvertColorsEnabled
    }

    var isMonoAudioEnabled: Bool {
        return UIAccessibility.isMonoAudioEnabled
    }

    var isReduceMotionEnabled: Bool {
        return UIAccessibility.isReduceMotionEnabled
    }

    var isReduceTransparencyEnabled: Bool {
        return UIAccessibility.isReduceTransparencyEnabled
    }

    var isSwitchControlEnabled: Bool {
        return UIAccessibility.isSwitchControlRunning
    }

    var isVoiceOverEnabled: Bool {
        return UIAccessibility.isVoiceOverRunning
    }

    #endif

    #if os(watchOS)

    var isBoldTextEnabled: Bool {
        let referenceFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        let isBoldText = referenceFont.fontName.localizedCaseInsensitiveContains("bold")
        return isBoldText
    }

    var largerTextCatagory: String {
        let referenceFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize
        return referenceFontSize.contentSizeString
    }

    var isReduceMotionEnabled: Bool {
        if #available(watchOS 4.0, *) {
            return WKAccessibilityIsReduceMotionEnabled()
        } else {
            Logger.warning("Unable to determine status for isReduceMotion since it is only available on watchOS 4 or later.")
            return false
        }
    }

    var isVoiceOverEnabled: Bool {
        return WKAccessibilityIsVoiceOverRunning()
    }

    #endif

    #if os(OSX)

    var isDifferentiateWithoutColorEnabled: Bool {
        return NSWorkspace.shared.accessibilityDisplayShouldDifferentiateWithoutColor
    }

    var isFullKeyboardAccessEnabled: Bool {
        return NSApplication.shared.isFullKeyboardAccessEnabled
    }

    var isIncreaseContrastEnabled: Bool {
        return NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast
    }

    var isInvertColorsEnabled: Bool {
        return NSWorkspace.shared.accessibilityDisplayShouldInvertColors
    }

    var isReduceMotionEnabled: Bool {
        return NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
    }

    var isReduceTransparencyEnabled: Bool {
        return NSWorkspace.shared.accessibilityDisplayShouldReduceTransparency
    }

    var isSwitchControlEnabled: Bool {
        if #available(OSX 10.13, *) {
            return NSWorkspace.shared.isSwitchControlEnabled
        } else {
            Logger.warning("Unable to determine status for switchControl since it is only available on macOS 10.13 or later.")
            return false
        }
    }

    var isVoiceOverEnabled: Bool {
        if #available(OSX 10.13, *) {
            return NSWorkspace.shared.isVoiceOverEnabled
        } else {
            Logger.warning("Unable to determine status for voiceOver since it is only available on macOS 10.13 or later.")
            return false
        }
    }

    #endif

    // swiftlint:disable cyclomatic_complexity
    func isFeatureEnabled(feature: CapableFeature) -> Bool {

        #if os(iOS)

        switch feature {
        case .assistiveTouch:
            return self.isAssistiveTouchEnabled
        case .boldText:
            return self.isBoldTextEnabled
        case .closedCaptioning:
            return self.isClosedCaptioningEnabled
        case .darkerSystemColors:
            return self.isDarkerSystemColorsEnabled
        case .grayscale:
            return self.isGrayscaleEnabled
        case .guidedAccess:
            return self.isGuidedAccessEnabled
        case .invertColors:
            return self.isInvertColorsEnabled
        case .largerText:
            return !ContentSizeHelper.isDefaultContentSizeCategory(contentSizeCategory: self.largerTextCatagory)
        case .monoAudio:
            return self.isMonoAudioEnabled
        case .shakeToUndo:
        if feature == .hearingDevice {
            return self.hearingDevicePairedEar.rawValue != 0
        }
            return self.isShakeToUndoEnabled
        case .speakScreen:
            return self.isSpeakScreenEnabled
        case .speakSelection:
            return self.isSpeakSelectionEnabled
        case .switchControl:
            return self.isSwitchControlEnabled
        case .reduceMotion:
            return self.isReduceMotionEnabled
        case .reduceTransparency:
            return self.isReduceTransparencyEnabled
        case .voiceOver:
            return self.isVoiceOverEnabled
        }

        #elseif os(tvOS)

        switch feature {
        case .boldText:
            return self.isBoldTextEnabled
        case .closedCaptioning:
            return self.isClosedCaptioningEnabled
        case .grayscale:
            return self.isGrayscaleEnabled
        case .invertColors:
            return self.isInvertColorsEnabled
        case .monoAudio:
            return self.isMonoAudioEnabled
        case .reduceMotion:
            return self.isReduceMotionEnabled
        case .reduceTransparency:
            return self.isReduceTransparencyEnabled
        case .switchControl:
            return self.isSwitchControlEnabled
        case .voiceOver:
            return self.isVoiceOverEnabled
        }

        #elseif os(watchOS)

        switch feature {
        case .boldText:
            return self.isBoldTextEnabled
        case .largerText:
            return !ContentSizeHelper.isDefaultContentSize(contentSize: self.largerTextCatagory)
        case .reduceMotion:
            return self.isReduceMotionEnabled
        case .voiceOver:
            return self.isVoiceOverEnabled
        }

        #elseif os(OSX)

        switch feature {
        case .differentiateWithoutColor:
            return self.isDifferentiateWithoutColorEnabled
        case .fullKeyboardAccess:
            return self.isFullKeyboardAccessEnabled
        case .increaseContrast:
            return self.isIncreaseContrastEnabled
        case .invertColors:
            return self.isInvertColorsEnabled
        case .reduceMotion:
            return self.isReduceMotionEnabled
        case .reduceTransparency:
            return self.isReduceTransparencyEnabled
        case .switchControl:
            return self.isSwitchControlEnabled
        case .voiceOver:
            return self.isVoiceOverEnabled
        }

        #endif

    }
    // swiftlint:enable cyclomatic_complexity
}
