//
//  Statuses.swift
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

class Statuses: StatusesProtocol {

    var features: [CapableFeature]

    required convenience init() {
        self.init(with: CapableFeature.allValues())
    }

    required init(with features: [CapableFeature]) {
        self.features = features
    }

    var statusMap: [String: String] {
        var featuresStatusMap = [String: String]()

        #if os(iOS)
            if self.features.contains(.assistiveTouch) {
                featuresStatusMap[CapableFeature.assistiveTouch.rawValue] = self.isAssistiveTouchEnabled.statusString
            }
            if self.features.contains(.darkerSystemColors) {
                featuresStatusMap[CapableFeature.darkerSystemColors.rawValue] = self.isDarkerSystemColorsEnabled.statusString
            }
            if self.features.contains(.guidedAccess) {
                featuresStatusMap[CapableFeature.guidedAccess.rawValue] = self.isGuidedAccessEnabled.statusString
            }
            if self.features.contains(.largerText) {
                featuresStatusMap[CapableFeature.largerText.rawValue] = self.largerTextCatagory.stringValue
            }
            if self.features.contains(.shakeToUndo) {
                featuresStatusMap[CapableFeature.shakeToUndo.rawValue] = self.isShakeToUndoEnabled.statusString
            }
            if self.features.contains(.speakScreen) {
                featuresStatusMap[CapableFeature.speakScreen.rawValue] = self.isSpeakScreenEnabled.statusString
            }
            if self.features.contains(.speakSelection) {
                featuresStatusMap[CapableFeature.speakSelection.rawValue] = self.isSpeakSelectionEnabled.statusString
            }
        #endif

        #if os(OSX)
        if self.features.contains(.differentiateWithoutColor) {
            featuresStatusMap[CapableFeature.differentiateWithoutColor.rawValue] = self.isDifferentiateWithoutColorEnabled.statusString
        }
        if self.features.contains(.increaseContrast) {
            featuresStatusMap[CapableFeature.increaseContrast.rawValue] = self.isIncreaseContrastEnabled.statusString
        }
        #endif

        #if os(watchOS)
            if self.features.contains(.largerText) {
                featuresStatusMap[CapableFeature.largerText.rawValue] = self.largerTextCatagory
            }
        #endif

        #if os(iOS) || os(tvOS)
            if self.features.contains(.closedCaptioning) {
                featuresStatusMap[CapableFeature.closedCaptioning.rawValue] = self.isClosedCaptioningEnabled.statusString
            }
            if self.features.contains(.grayscale) {
                featuresStatusMap[CapableFeature.grayscale.rawValue] = self.isGrayscaleEnabled.statusString
            }
            if self.features.contains(.invertColors) {
                featuresStatusMap[CapableFeature.invertColors.rawValue] = self.isInvertColorsEnabled.statusString
            }
            if self.features.contains(.monoAudio) {
                featuresStatusMap[CapableFeature.monoAudio.rawValue] = self.isMonoAudioEnabled.statusString
            }
        #endif

        #if os(iOS) || os(OSX)
            if self.features.contains(.invertColors) {
                featuresStatusMap[CapableFeature.invertColors.rawValue] = self.isInvertColorsEnabled.statusString
            }
        #endif

        #if os(iOS) || os(tvOS) || os(watchOS)
            if self.features.contains(.boldText) {
                featuresStatusMap[CapableFeature.boldText.rawValue] = self.isBoldTextEnabled.statusString
            }
        #endif

        #if os(iOS) || os(tvOS) || os(OSX)
            if self.features.contains(.reduceTransparency) {
                featuresStatusMap[CapableFeature.reduceTransparency.rawValue] = self.isReduceTransparencyEnabled.statusString
            }
            if self.features.contains(.switchControl) {
                featuresStatusMap[CapableFeature.switchControl.rawValue] = self.isSwitchControlEnabled.statusString
            }
        #endif

        if self.features.contains(.reduceMotion) {
            featuresStatusMap[CapableFeature.reduceMotion.rawValue] = self.isReduceMotionEnabled.statusString
        }
        if self.features.contains(.voiceOver) {
            featuresStatusMap[CapableFeature.voiceOver.rawValue] = self.isVoiceOverEnabled.statusString
        }

        return featuresStatusMap
    }

    #if os(iOS)
        var isAssistiveTouchEnabled: Bool {
            return UIAccessibilityIsAssistiveTouchRunning()
        }

        var isDarkerSystemColorsEnabled: Bool {
            return UIAccessibilityDarkerSystemColorsEnabled()
        }

        var isGuidedAccessEnabled: Bool {
            return UIAccessibilityIsGuidedAccessEnabled()
        }

        var largerTextCatagory: UIContentSizeCategory {
            return UIScreen.main.traitCollection.preferredContentSizeCategory
        }

        var isShakeToUndoEnabled: Bool {
            return UIAccessibilityIsShakeToUndoEnabled()
        }

        var isSpeakScreenEnabled: Bool {
            return UIAccessibilityIsSpeakScreenEnabled()
        }

        var isSpeakSelectionEnabled: Bool {
            return UIAccessibilityIsSpeakSelectionEnabled()
        }
    #endif

    #if os(iOS) || os(tvOS)
        var isBoldTextEnabled: Bool {
            return UIAccessibilityIsBoldTextEnabled()
        }

        var isClosedCaptioningEnabled: Bool {
            return UIAccessibilityIsClosedCaptioningEnabled()
        }

        var isGrayscaleEnabled: Bool {
            return UIAccessibilityIsGrayscaleEnabled()
        }

        var isInvertColorsEnabled: Bool {
            return UIAccessibilityIsInvertColorsEnabled()
        }

        var isMonoAudioEnabled: Bool {
            return UIAccessibilityIsSpeakScreenEnabled()
        }

        var isReduceMotionEnabled: Bool {
            return UIAccessibilityIsReduceMotionEnabled()
        }

        var isReduceTransparencyEnabled: Bool {
            return UIAccessibilityIsReduceTransparencyEnabled()
        }

        var isSwitchControlEnabled: Bool {
            return UIAccessibilityIsSwitchControlRunning()
        }

        var isVoiceOverEnabled: Bool {
            return UIAccessibilityIsVoiceOverRunning()
        }
    #endif

    #if os(watchOS)
        var isBoldTextEnabled: Bool {
            let referenceFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
            let isBoldText = referenceFont.fontName.localizedCaseInsensitiveContains("bold")
            return isBoldText
        }

        var largerTextCatagory: String {
            let referenceFontSize = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize
            return referenceFontSize.contentSizeString
        }

        var isReduceMotionEnabled: Bool {
            if #available(watchOS 4.0, *) {
                return WKAccessibilityIsReduceMotionEnabled()
            } else {
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
                return false
            }
        }

        var isVoiceOverEnabled: Bool {
            if #available(OSX 10.13, *) {
                return NSWorkspace.shared.isVoiceOverEnabled
            } else {
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
