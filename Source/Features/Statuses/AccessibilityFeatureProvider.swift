//
//  FeatureProvider.swift
//  Pods
//
//  Created by Christoph Wendt on 03.05.21.
//

import Foundation

protocol FeatureProviderProtocol {
    func feature(featureName: String) -> FeatureProtocol?
}

class FeatureProvider: FeatureProviderProtocol {
    func feature(featureName: String) -> FeatureProtocol? {
        switch featureName {
        case AssistiveTouch.name: return AssistiveTouch()
        case BoldText.name: return BoldText()
        case ButtonShapes.name: return ButtonShapes()
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
        case PrefersCrossFadeTransitions.name: return PrefersCrossFadeTransitions()
        case ReduceMotion.name: return ReduceMotion()
        case ReduceTransparency.name: return ReduceTransparency()
        case ShakeToUndo.name: return ShakeToUndo()
        case SpeakScreen.name: return SpeakScreen()
        case SpeakSelection.name: return SpeakSelection()
        case SwitchControl.name: return SwitchControl()
        case VideoAutoplay.name: return VideoAutoplay()
        case VoiceOver.name: return VoiceOver()
        default:
            Logger.error("Could not feature name \(featureName) to accessibility feature object.")
            return nil
        }
    }
}
