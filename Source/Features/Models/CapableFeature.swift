//
//  CapableFeature.swift
//  Capable
//
//  Created by Christoph Wendt on 23.03.18.
//

public enum CapableFeature: String {
    case AssistiveTouch
    case BoldText
    case ClosedCaptioning
    case DarkerSystemColors
    case Grayscale
    case GuidedAccess
    case InvertColors
    case LargerText
    case MonoAudio
    case ReduceMotion
    case ReduceTransparency
    case ShakeToUndo
    case SpeakScreen
    case SpeakSelection
    case SwitchControl
    case VoiceOver
    
    public static func allValues() -> [CapableFeature] {
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
    }
}
