//
//  Notifications.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(watchOS)
import WatchKit
#endif

class Notifications: NotificationsProtocol {
    var statusesModule: StatusesProtocol

    required init(statusesModule: StatusesProtocol) {
        self.statusesModule = statusesModule
    }
}

// MARK: Register Observers
extension Notifications {

    // swiftlint:disable cyclomatic_complexity
    func enableNotifications(for features: [CapableFeature]) {
        #if os(iOS)
            if features.contains(.assistiveTouch) {
                addObserver(for: .UIAccessibilityAssistiveTouchStatusDidChange, selector: #selector(self.assistiveTouchStatusChanged))
            }
            if features.contains(.darkerSystemColors) {
                addObserver(for: .UIAccessibilityDarkerSystemColorsStatusDidChange, selector: #selector(self.darkerSystemColorsStatusChanged))
            }
            if features.contains(.guidedAccess) {
                addObserver(for: .UIAccessibilityGuidedAccessStatusDidChange, selector: #selector(self.guidedAccessStatusChanged))
            }
            if features.contains(.invertColors) {
                addObserver(for: .UIAccessibilityInvertColorsStatusDidChange, selector: #selector(self.invertColorsStatusChanged))
            }
            if features.contains(.largerText) {
                addObserver(for: .UIContentSizeCategoryDidChange, selector: #selector(self.largerTextStatusChanged))
            }
            if features.contains(.shakeToUndo) {
                addObserver(for: .UIAccessibilityShakeToUndoDidChange, selector: #selector(self.shakeToUndoStatusChanged))
            }
            if features.contains(.speakScreen) {
                addObserver(for: .UIAccessibilitySpeakScreenStatusDidChange, selector: #selector(self.speakScreenStatusChanged))
            }
            if features.contains(.speakSelection) {
                addObserver(for: .UIAccessibilitySpeakSelectionStatusDidChange, selector: #selector(self.speakSelectionStatusChanged))
            }
        #endif

        #if os(iOS) || os(tvOS)
            if features.contains(.boldText) {
                addObserver(for: .UIAccessibilityBoldTextStatusDidChange, selector: #selector(self.boldTextStatusChanged))
            }
            if features.contains(.closedCaptioning) {
                addObserver(for: .UIAccessibilityClosedCaptioningStatusDidChange, selector: #selector(self.closedCaptioningStatusChanged))
            }
            if features.contains(.grayscale) {
                addObserver(for: .UIAccessibilityGrayscaleStatusDidChange, selector: #selector(self.grayscaleStatusChanged))
            }
            if features.contains(.monoAudio) {
                addObserver(for: .UIAccessibilityMonoAudioStatusDidChange, selector: #selector(self.monoAudioStatusChanged))
            }
            if features.contains(.switchControl) {
                addObserver(for: .UIAccessibilitySwitchControlStatusDidChange, selector: #selector(self.switchControlStatusChanged))
            }
            if features.contains(.reduceMotion) {
                addObserver(for: .UIAccessibilityReduceMotionStatusDidChange, selector: #selector(self.reduceMotionStatusChanged))
            }
            if features.contains(.reduceTransparency) {
                addObserver(for: .UIAccessibilityReduceTransparencyStatusDidChange, selector: #selector(self.reduceTransparencyStatusChanged))
            }
            if features.contains(.voiceOver) {
                if #available(iOS 11.0, tvOS 11.0, *) {
                    addObserver(for: .UIAccessibilityVoiceOverStatusDidChange, selector: #selector(self.voiceOverStatusChanged))
                } else {
                    addObserver(for: Notification.Name(UIAccessibilityVoiceOverStatusChanged), selector: #selector(self.voiceOverStatusChanged))
                }
            }
        #endif

        #if os(watchOS)
            if #available(watchOS 4.0, *), features.contains(.reduceMotion) {
                addObserver(for: .WKAccessibilityReduceMotionStatusDidChange, selector: #selector(self.reduceMotionStatusChanged))
            }
            if features.contains(.voiceOver) {
                addObserver(for: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged), selector: #selector(self.voiceOverStatusChanged))
            }
        #endif
    }
    // swiftlint:enable cyclomatic_complexity
}

// MARK: Handle notifications
extension Notifications {
    func addObserver(for notificationName: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: notificationName,
            object: nil)
    }

    #if os(iOS)
    @objc func assistiveTouchStatusChanged(notification: NSNotification) {
        postNotification(with: .assistiveTouch, statusString: self.statusesModule.isAssistiveTouchEnabled.statusString)
    }

    @objc func darkerSystemColorsStatusChanged(notification: NSNotification) {
        self.postNotification(with: .darkerSystemColors, statusString: self.statusesModule.isDarkerSystemColorsEnabled.statusString)
    }

    @objc func guidedAccessStatusChanged(notification: NSNotification) {
        self.postNotification(with: .guidedAccess, statusString: self.statusesModule.isGuidedAccessEnabled.statusString)
    }

    @objc func invertColorsStatusChanged(notification: NSNotification) {
        self.postNotification(with: .invertColors, statusString: self.statusesModule.isInvertColorsEnabled.statusString)
    }

    @objc func largerTextStatusChanged(notification: NSNotification) {
        self.postNotification(with: .largerText, statusString: self.statusesModule.largerTextCatagory.stringValue)
    }

    @objc func shakeToUndoStatusChanged(notification: NSNotification) {
        self.postNotification(with: .shakeToUndo, statusString: self.statusesModule.isShakeToUndoEnabled.statusString)
    }

    @objc func speakScreenStatusChanged(notification: NSNotification) {
        self.postNotification(with: .speakScreen, statusString: self.statusesModule.isSpeakScreenEnabled.statusString)
    }

    @objc func speakSelectionStatusChanged(notification: NSNotification) {
        self.postNotification(with: .speakSelection, statusString: self.statusesModule.isSpeakSelectionEnabled.statusString)
    }
    #endif

    #if os(iOS) || os(tvOS)
    @objc func boldTextStatusChanged(notification: NSNotification) {
        self.postNotification(with: .boldText, statusString: self.statusesModule.isBoldTextEnabled.statusString)
    }

    @objc func closedCaptioningStatusChanged(notification: NSNotification) {
        self.postNotification(with: .closedCaptioning, statusString: self.statusesModule.isClosedCaptioningEnabled.statusString)
    }

    @objc func grayscaleStatusChanged(notification: NSNotification) {
        self.postNotification(with: .grayscale, statusString: self.statusesModule.isGrayscaleEnabled.statusString)
    }

    @objc func monoAudioStatusChanged(notification: NSNotification) {
        self.postNotification(with: .monoAudio, statusString: self.statusesModule.isMonoAudioEnabled.statusString)
    }

    @objc func switchControlStatusChanged(notification: NSNotification) {
        self.postNotification(with: .switchControl, statusString: self.statusesModule.isSwitchControlEnabled.statusString)
    }

    @objc func reduceTransparencyStatusChanged(notification: NSNotification) {
        self.postNotification(with: .reduceTransparency, statusString: self.statusesModule.isReduceTransparencyEnabled.statusString)
    }
    #endif

    @objc func reduceMotionStatusChanged(notification: NSNotification) {
        self.postNotification(with: .reduceMotion, statusString: self.statusesModule.isReduceMotionEnabled.statusString)
    }

    @objc private func voiceOverStatusChanged(notification: NSNotification) {
        self.postNotification(with: .voiceOver, statusString: self.statusesModule.isVoiceOverEnabled.statusString)
    }
}

// MARK: Post notifications
extension Notifications {
    func postNotification(with feature: CapableFeature, statusString: String) {
        let featureStatus = FeatureStatus(with: feature, statusString: statusString)
        NotificationCenter.default.post(name: .CapableFeatureStatusDidChange, object: featureStatus)
    }
}
