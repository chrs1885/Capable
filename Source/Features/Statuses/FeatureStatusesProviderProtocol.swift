//
//  FeatureStatusesProviderProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

#if os(iOS)
import UIKit
#endif

protocol FeatureStatusesProviderProtocol {

    #if os(iOS)
    var isAssistiveTouchEnabled: Bool { get }
    var isDarkerSystemColorsEnabled: Bool { get }
    var isGuidedAccessEnabled: Bool { get }
    var largerTextCatagory: UIContentSizeCategory { get }
    var isShakeToUndoEnabled: Bool { get }
    var isSpeakScreenEnabled: Bool { get }
    var isSpeakSelectionEnabled: Bool { get }
    #endif

    #if os(iOS) || os(tvOS)
    var isClosedCaptioningEnabled: Bool { get }
    var isGrayscaleEnabled: Bool { get }
    var isMonoAudioEnabled: Bool { get }
    var isReduceTransparencyEnabled: Bool { get }
    #endif

    #if os(iOS) || os(tvOS) || os(watchOS)
    var isBoldTextEnabled: Bool { get }
    #endif

    #if os(iOS) || os(tvOS) || os(OSX)
    var isInvertColorsEnabled: Bool { get }
    var isSwitchControlEnabled: Bool { get }
    #endif

    #if os(OSX)
    var isDifferentiateWithoutColorEnabled: Bool { get }
    var isFullKeyboardAccessEnabled: Bool { get }
    var isIncreaseContrastEnabled: Bool  { get }
    #endif

    #if os(watchOS)
    var largerTextCatagory: String { get }
    #endif

    var isReduceMotionEnabled: Bool { get }
    var isVoiceOverEnabled: Bool { get }

    func isFeatureEnabled(feature: CapableFeature) -> Bool
}
