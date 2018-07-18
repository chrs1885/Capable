//
//  CapableFeature.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

/// An enum specifying all features available on the current platform.
public enum CapableFeature: String {

    #if os(iOS)
        /// Menu that helps people with motor skill impairments to do certain actions or gestures by using a single tap.
        case AssistiveTouch

        /// Enhances text contrast.
        case DarkerSystemColors

        /// Restricts access to certain features of a single app to keep the user focused.
        case GuidedAccess

        /// Delete the last command by shaking the phone.
        case ShakeToUndo

        /// Reads out the content of the current screen.
        case SpeakScreen

        /// Reads out the selected content.
        case SpeakSelection
    #endif

    #if os(iOS) || os(tvOS)
        /// Display subtitles when playing videos.
        case ClosedCaptioning

        /// Makes the display more readable for color blind people by using gray tones instead of colors.
        case Grayscale

        /// Helps people with low vision, color blindness, sensitivity to brightness to read the display content.
        case InvertColors

        /// Merges stereo channels to help users that are hard of hearing or deaf in one ear.
        case MonoAudio

        /// Removes transparency from layers to make them readable for users with visual impairment.
        case ReduceTransparency

        /// Allows users with limited mobility to control their device with the help of ability switches and other adaptive devices.
        case SwitchControl
    #endif

    #if os(iOS) || os(watchOS)
        /// Increases legibility by making fonts bigger.
        case LargerText
    #endif

    #if os(iOS) || os(tvOS) || os(watchOS)
        /// Increases legibility by making fonts heavier.
        case BoldText
    #endif

    /// Reduces animations to help users with motion sickness and epilepsy issues.
    case ReduceMotion

    /// The screen reader available on Apple platforms.
    case VoiceOver

    /**
     Returns an array containing all `CapableFaeture` types available on the current platform.

     - Returns: An array containing all `CapableFaeture` types available on the current platform.
     */
    public static func allValues() -> [CapableFeature] {
        #if os(iOS)
        return [
            .AssistiveTouch,
            .BoldText,
            .ClosedCaptioning,
            .DarkerSystemColors,
            .Grayscale,
            .GuidedAccess,
            .InvertColors,
            .LargerText,
            .MonoAudio,
            .ReduceMotion,
            .ReduceTransparency,
            .ShakeToUndo,
            .SpeakScreen,
            .SpeakSelection,
            .SwitchControl,
            .VoiceOver ]
        #elseif os(tvOS)
        return [
            .BoldText,
            .ClosedCaptioning,
            .Grayscale,
            .InvertColors,
            .MonoAudio,
            .ReduceMotion,
            .ReduceTransparency,
            .SwitchControl,
            .VoiceOver ]
        #elseif os(watchOS)
        return [
            .BoldText,
            .LargerText,
            .ReduceMotion,
            .VoiceOver ]
        #endif
    }

    /**
     Iterates through a given list of feature types and returns an array containing the feature names as strings.

     - Parameters:
        - features: An array containing the feature types of interest.

     - Returns: An array containing the feature names as strings
     */
    public static func keys(forFeatures features: [CapableFeature]) -> [String] {
        return features.map {$0.rawValue}
    }
}
