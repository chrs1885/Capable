//
//  CapableFeature.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

public enum CapableFeature: String {
    #if os(iOS) || os(tvOS)
    case AssistiveTouch
    case BoldText
    case ClosedCaptioning
    case DarkerSystemColors
    case Grayscale
    case GuidedAccess
    case InvertColors
    case LargerText
    case MonoAudio
    case ReduceTransparency
    case ShakeToUndo
    case SpeakScreen
    case SpeakSelection
    case SwitchControl
    #endif
    
    case ReduceMotion
    case VoiceOver
    
    public static func allValues() -> [CapableFeature] {
        #if os(iOS) || os(tvOS)
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
            .VoiceOver,]
        #elseif os(watchOS)
        return [
            .ReduceMotion,
            .VoiceOver,]
        #endif
    }
    
    public static func keys(forFeatures features: [CapableFeature]) -> [String] {
        return features.map {$0.rawValue}
    }
}
