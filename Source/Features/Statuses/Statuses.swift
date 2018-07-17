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
            if self.features.contains(.invertColors) {
                featuresStatusMap[CapableFeature.invertColors.rawValue] = self.isInvertColorsEnabled.statusString
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

        #if os(iOS) || os(tvOS)
            if self.features.contains(.closedCaptioning) {
                featuresStatusMap[CapableFeature.closedCaptioning.rawValue] = self.isClosedCaptioningEnabled.statusString
            }
            if self.features.contains(.grayscale) {
                featuresStatusMap[CapableFeature.grayscale.rawValue] = self.isGrayscaleEnabled.statusString
            }
            if self.features.contains(.monoAudio) {
                featuresStatusMap[CapableFeature.monoAudio.rawValue] = self.isMonoAudioEnabled.statusString
            }
            if self.features.contains(.reduceTransparency) {
                featuresStatusMap[CapableFeature.reduceTransparency.rawValue] = self.isReduceTransparencyEnabled.statusString
            }
            if self.features.contains(.switchControl) {
                featuresStatusMap[CapableFeature.switchControl.rawValue] = self.isSwitchControlEnabled.statusString
            }
        #endif

        #if os(watchOS)
            if self.features.contains(.largerText) {
                featuresStatusMap[CapableFeature.largerText.rawValue] = self.largerTextCatagory
            }
        #endif

        if self.features.contains(.boldText) {
            featuresStatusMap[CapableFeature.boldText.rawValue] = self.isBoldTextEnabled.statusString
        }
        if self.features.contains(.reduceMotion) {
            featuresStatusMap[CapableFeature.reduceMotion.rawValue] = self.isReduceMotionEnabled.statusString
        }
        if self.features.contains(.voiceOver) {
            featuresStatusMap[CapableFeature.voiceOver.rawValue] = self.isVoiceOverEnabled.statusString
        }

        return featuresStatusMap
    }

    #if os(iOS) || os(tvOS)
        var isAssistiveTouchEnabled: Bool {
            return UIAccessibilityIsAssistiveTouchRunning()
        }

        var isBoldTextEnabled: Bool {
            return UIAccessibilityIsBoldTextEnabled()
        }

        var isClosedCaptioningEnabled: Bool {
            return UIAccessibilityIsClosedCaptioningEnabled()
        }

        var isDarkerSystemColorsEnabled: Bool {
            return UIAccessibilityDarkerSystemColorsEnabled()
        }

        var isGrayscaleEnabled: Bool {
            return UIAccessibilityIsGrayscaleEnabled()
        }

        var isGuidedAccessEnabled: Bool {
            return UIAccessibilityIsGuidedAccessEnabled()
        }

        var isInvertColorsEnabled: Bool {
            return UIAccessibilityIsInvertColorsEnabled()
        }

        var largerTextCatagory: UIContentSizeCategory {
            return UIScreen.main.traitCollection.preferredContentSizeCategory
        }

        var isMonoAudioEnabled: Bool {
            return UIAccessibilityIsSpeakScreenEnabled()
        }

        var isReduceTransparencyEnabled: Bool {
            return UIAccessibilityIsReduceTransparencyEnabled()
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

        var isSwitchControlEnabled: Bool {
            return UIAccessibilityIsSwitchControlRunning()
        }
    #elseif os(watchOS)
        var isBoldTextEnabled: Bool {
            let referenceFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
            let isBoldText = referenceFont.fontName.localizedCaseInsensitiveContains("bold")
            return isBoldText
        }

        var largerTextCatagory: String {
            let referenceFontSize = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize
            return referenceFontSize.contentSizeString
        }
    #endif

    var isReduceMotionEnabled: Bool {
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

    var isVoiceOverEnabled: Bool {
        #if os(watchOS)
            return WKAccessibilityIsVoiceOverRunning()
        #else
            return UIAccessibilityIsVoiceOverRunning()
        #endif
    }

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
        #endif
    }
    // swiftlint:enable cyclomatic_complexity
}
