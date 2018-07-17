//
//  CapableFeature.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

public enum CapableFeature: String {
    #if os(iOS)
    case assistiveTouch
    case darkerSystemColors
    case guidedAccess
    case invertColors
    case shakeToUndo
    case speakScreen
    case speakSelection
    #endif

    #if os(iOS) || os(tvOS)
    case closedCaptioning
    case grayscale
    case monoAudio
    case reduceTransparency
    case switchControl
    #endif

    #if os(iOS) || os(watchOS)
    case largerText
    #endif

    #if os(iOS) || os(tvOS) || os(watchOS)
    case boldText
    #endif

    case reduceMotion
    case voiceOver

    public static func allValues() -> [CapableFeature] {
        #if os(iOS)
        return [
            .assistiveTouch,
            .boldText,
            .closedCaptioning,
            .darkerSystemColors,
            .grayscale,
            .guidedAccess,
            .invertColors,
            .largerText,
            .monoAudio,
            .reduceMotion,
            .reduceTransparency,
            .shakeToUndo,
            .speakScreen,
            .speakSelection,
            .switchControl,
            .voiceOver]
        #elseif os(tvOS)
        return [
            .boldText,
            .closedCaptioning,
            .grayscale,
            .monoAudio,
            .reduceMotion,
            .reduceTransparency,
            .switchControl,
            .voiceOver]
        #elseif os(watchOS)
        return [
            .boldText,
            .largerText,
            .reduceMotion,
            .voiceOver]
        #endif
    }

    public static func keys(forFeatures features: [CapableFeature]) -> [String] {
        return features.map {$0.rawValue}
    }
}
