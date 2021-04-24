//
//  CapableFeature.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

/// An enum specifying all features available on the current platform.
public enum CapableFeature: String, CaseIterable {
    #if os(iOS)

        /// Menu that helps people with motor skill impairments to do certain actions or gestures by using a single tap.
        case assistiveTouch

        /// Enhances text contrast.
        case darkerSystemColors

        /// Restricts access to certain features of a single app to keep the user focused.
        case guidedAccess

        /// Pairing status of a hearing aid.
        case hearingDevicePairedEar

        /// Displays on/off labels for UISwitch controls.
        case onOffSwitchLabels

        /// Deletes the last command by shaking the phone.
        case shakeToUndo

        /// Reads out the content of the current screen.
        case speakScreen

        /// Reads out the selected content.
        case speakSelection

    #endif

    #if os(OSX)

        /// Enables users to navigate through items of the screen without having to use a mouse.
        case fullKeyboardAccess

        /// Increases contrast to make out text and interface elements.
        case increaseContrast

    #endif

    #if os(iOS) || os(tvOS)

        /// Displays subtitles when playing videos.
        case closedCaptioning

        /// Makes the display more readable for color blind people by using gray tones instead of colors.
        case grayscale

        /// Merges stereo audio channels to help users that are hard of hearing or deaf in one ear.
        case monoAudio

        /// Allows users who are sensitive to motion to disable automatic video playback.
        case videoAutoplay

    #endif

    #if os(iOS) || os(watchOS)

        /// Increases legibility by making fonts bigger.
        case largerText

    #endif

    #if os(iOS) || os(OSX)

        /// Helps color blind users to differentiate settings differently, e.g. by using shapes rather than colors.
        case differentiateWithoutColor

    #endif

    #if os(iOS) || os(tvOS) || os(OSX)

        /// Helps people with low vision, color blindness, or sensitivity to brightness to read the display content.
        case invertColors

        /// Removes transparency from layers to make them readable for users with visual impairment.
        case reduceTransparency

        /// Allows users with limited mobility to control their device with the help of ability switches and other adaptive devices.
        case switchControl

    #endif

    #if os(iOS) || os(tvOS) || os(watchOS)

        /// Increases legibility by making fonts heavier.
        case boldText

    #endif

    /// Reduces animations to help users with motion sickness and epilepsy issues.
    case reduceMotion

    /// The screen reader available on Apple platforms.
    case voiceOver

    /**
     Iterates through a given list of feature types and returns an array containing the feature names as strings.

     - Parameters:
        - features: An array containing the feature types of interest.

     - Returns: An array containing the feature names as strings
     */
    public static func keys(forFeatures features: [CapableFeature]) -> [String] {
        return features.map { $0.rawValue }
    }

    var accessibilityFeature: AccessibilityFeatureProtocol? {
        switch rawValue {
        case AssistiveTouch.name: return AssistiveTouch()
        case BoldText.name: return BoldText()
        case ClosedCaptioning.name: return ClosedCaptioning()
        case DarkerSystemColors.name: return DarkerSystemColors()
        case DifferentiateWithoutColor.name: return DifferentiateWithoutColor()
        case FullKeyboardAccess.name: return FullKeyboardAccess()
        case Grayscale.name: return Grayscale()
        case GuidedAccess.name: return GuidedAccess()
        case HearingDevicePairedEar.name: return HearingDevicePairedEar()
        case IncreaseContrast.name: return IncreaseContrast()
        case InvertColors.name: return InvertColors()
        case LargerText.name: return LargerText()
        case MonoAudio.name: return MonoAudio()
        case OnOffSwitchLabels.name: return OnOffSwitchLabels()
        case ReduceMotion.name: return ReduceMotion()
        case ReduceTransparency.name: return ReduceTransparency()
        case ShakeToUndo.name: return ShakeToUndo()
        case SpeakScreen.name: return SpeakScreen()
        case SpeakSelection.name: return SpeakSelection()
        case SwitchControl.name: return SwitchControl()
        case VideoAutoplay.name: return VideoAutoplay()
        case VoiceOver.name: return VoiceOver()
        default:
            Logger.error("Could not map CpableFeature case \(rawValue) to feature object.")
        }

        return nil
    }
}
