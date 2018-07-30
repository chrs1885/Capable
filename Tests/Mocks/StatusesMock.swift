//
//  StatusesMock.swift
//  Capable
//
//  Created by Christoph Wendt on 18.04.18.
//

#if os(iOS) || os(tvOS) || os(OSX)
import Foundation

#if os(iOS)
import UIKit
#endif

class StatusesMock: Statuses {

    #if os(iOS)
    var assistiveTouchEnabled: Bool = false
    var darkerSystemColorsEnabled: Bool = false
    var textCatagory: UIContentSizeCategory = .unspecified
    var guidedAccessEnabled: Bool = false
    var shakeToUndoEnabled: Bool = false
    var speakScreenEnabled: Bool = false
    var speakSelectionEnabled: Bool = false
    #endif

    #if os(iOS) || os(tvOS)
    var boldTextEnabled: Bool = false
    var closedCaptioningEnabled: Bool = false
    var grayscaleEnabled: Bool = false
    var monoAudioEnabled: Bool = false
    var reduceTransparencyEnabled: Bool = false
    #endif

    #if os(iOS) || os(OSX)
    var invertColorsEnabled: Bool = false
    #endif

    var reduceMotionEnabled: Bool = false
    var switchControlEnabled: Bool = false
    var voiceOverEnabled: Bool = false

    required convenience init() {
        self.init(with: CapableFeature.allValues())
    }

    required init(with features: [CapableFeature]) {
        super.init(with: features)
    }

    #if os(iOS)
        override var isAssistiveTouchEnabled: Bool {
            return assistiveTouchEnabled
        }

        override var isDarkerSystemColorsEnabled: Bool {
            return darkerSystemColorsEnabled
        }

        override var largerTextCatagory: UIContentSizeCategory {
            return textCatagory
        }

        override var isGuidedAccessEnabled: Bool {
            return guidedAccessEnabled
        }

        override var isShakeToUndoEnabled: Bool {
            return shakeToUndoEnabled
        }

        override var isSpeakScreenEnabled: Bool {
            return speakScreenEnabled
        }

        override var isSpeakSelectionEnabled: Bool {
            return speakSelectionEnabled
        }
    #endif

    #if os(iOS) || os(tvOS)
        override var isBoldTextEnabled: Bool {
            return boldTextEnabled
        }

        override var isClosedCaptioningEnabled: Bool {
            return closedCaptioningEnabled
        }

        override var isGrayscaleEnabled: Bool {
            return grayscaleEnabled
        }

        override var isMonoAudioEnabled: Bool {
            return monoAudioEnabled
        }

        override var isReduceTransparencyEnabled: Bool {
            return reduceTransparencyEnabled
        }
    #endif

    #if os(iOS) || os(OSX)
        override var isInvertColorsEnabled: Bool {
            return invertColorsEnabled
        }
    #endif

    override var isReduceMotionEnabled: Bool {
        return reduceMotionEnabled
    }

    override var isSwitchControlEnabled: Bool {
        return switchControlEnabled
    }

    override var isVoiceOverEnabled: Bool {
        return voiceOverEnabled
    }
}
#endif
