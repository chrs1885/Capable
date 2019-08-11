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

    var isDifferentiateWithoutColorEnabled: Bool {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return UIAccessibility.shouldDifferentiateWithoutColor
        } else {
            Logger.warning("Unable to determine status for isDifferentiateWithoutColorEnabled since it is only available on iOS 13 / tvOS 13 or later.")
            return false
        }
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
    
    var isOnOffSwitchLabelsEnabled: Bool {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return UIAccessibility.isOnOffSwitchLabelsEnabled
        } else {
            Logger.warning("Unable to determine status for isOnOffSwitchLabelsEnabled since it is only available on iOS 13 / tvOS 13 or later.")
            return false
        }
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

    var isVideoAutoplayEnabled: Bool {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return UIAccessibility.isVideoAutoplayEnabled
        } else {
            Logger.warning("Unable to determine status for isVideoAutoplayEnabled since it is only available on iOS 13 / tvOS 13 or later.")
            return false
        }
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

        if feature == .assistiveTouch {
            return self.isAssistiveTouchEnabled
        }
        if feature == .darkerSystemColors {
            return self.isDarkerSystemColorsEnabled
        }
        if feature == .guidedAccess {
            return self.isGuidedAccessEnabled
        }
        if feature == .hearingDevice {
            return self.hearingDevicePairedEar.rawValue != 0
        }
        if feature == .largerText {
            return !self.largerTextCatagory.isDefault
        }
        if feature == .shakeToUndo {
            return self.isShakeToUndoEnabled
        }
        if feature == .speakScreen {
            return self.isSpeakScreenEnabled
        }
        if feature == .speakSelection {
            return self.isSpeakSelectionEnabled
        }

        #endif

        #if os(watchOS)

        if feature == .largerText {
            return !self.largerTextCatagory.isDefaultContentSizeString
        }

        #endif

        #if os(OSX)

        if feature == .fullKeyboardAccess {
            return self.isFullKeyboardAccessEnabled
        }
        if feature == .increaseContrast {
            return self.isIncreaseContrastEnabled
        }

        #endif

        #if os(iOS) || os(tvOS)

        if feature == .closedCaptioning {
            return self.isClosedCaptioningEnabled
        }
        if feature == .grayscale {
            return self.isGrayscaleEnabled
        }
        if feature == .monoAudio {
            return self.isMonoAudioEnabled
        }
        if feature == .onOffSwitchLabels {
            return self.isOnOffSwitchLabelsEnabled
        }
        if feature == .videoAutoplay {
            return self.isVideoAutoplayEnabled
        }

        #endif

        #if os(iOS) || os(tvOS) || os(macOS)

        if feature == .differentiateWithoutColor {
            return self.isDifferentiateWithoutColorEnabled
        }
        if feature == .invertColors {
            return self.isInvertColorsEnabled
        }
        if feature == .reduceTransparency {
            return self.isReduceTransparencyEnabled
        }
        if feature == .switchControl {
            return self.isSwitchControlEnabled
        }

        #endif

        #if os(iOS) || os(tvOS) || os(watchOS)

        if feature == .boldText {
            return self.isBoldTextEnabled
        }

        #endif

        if feature == .reduceMotion {
            return self.isReduceMotionEnabled
        }
        if feature == .voiceOver {
            return self.isVoiceOverEnabled
        }

        Logger.warning("Feature \(feature) was not handled in isFeatureEnabled. Returning false.")
        return false
    }
    // swiftlint:enable cyclomatic_complexity
}
