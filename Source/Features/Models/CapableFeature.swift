//
//  CapableFeature.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

public enum CapableFeature: String {
    #if os(iOS)
    case AssistiveTouch
    case DarkerSystemColors
    case GuidedAccess
    case ShakeToUndo
    case SpeakScreen
    case SpeakSelection
    #endif
    
    #if os(iOS) || os(tvOS)
    case ClosedCaptioning
    case Grayscale
    case InvertColors
    case MonoAudio
    case ReduceTransparency
    case SwitchControl
    #endif
    
    #if os(iOS) || os(watchOS)
    case LargerText
    #endif
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    case BoldText
    #endif
    
    case ReduceMotion
    case VoiceOver
    
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
            .VoiceOver,]
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
            .VoiceOver,]
        #elseif os(watchOS)
        return [
            .BoldText,
            .LargerText,
            .ReduceMotion,
            .VoiceOver,]
        #endif
    }
    
    public static func keys(forFeatures features: [CapableFeature]) -> [String] {
        return features.map {$0.rawValue}
    }
}
