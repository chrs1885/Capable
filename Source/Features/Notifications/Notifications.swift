//
//  Notifications.swift
//  Capable
//
//  Created by Christoph Wendt on 30.03.18.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(watchOS)
import WatchKit
#endif

class Notifications: NotificationsProtocol {
    var featureStatusesProvider: FeatureStatusesProviderProtocol
    var notificationCenter: NotificationCenter

    required init(featureStatusesProvider: FeatureStatusesProviderProtocol, notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.featureStatusesProvider = featureStatusesProvider
        self.notificationCenter = notificationCenter
    }

    func postNotification(withFeature feature: CapableFeature, statusString: String) {
        fatalError("Capable.Notifications.postNotification: Function needs to be implemented by its subclass.")
    }
}

// MARK: Register Observers
extension Notifications {

    // swiftlint:disable cyclomatic_complexity
    func enableNotifications(forFeatures features: [CapableFeature]) {
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
            if features.contains(.invertColors) {
                addObserver(for: .UIAccessibilityInvertColorsStatusDidChange, selector: #selector(self.invertColorsStatusChanged))
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
        self.notificationCenter.addObserver(
            self,
            selector: selector,
            name: notificationName,
            object: nil)
    }

    #if os(iOS)
    @objc func assistiveTouchStatusChanged(notification: NSNotification) {
        postNotification(withFeature: .assistiveTouch, statusString: self.featureStatusesProvider.isAssistiveTouchEnabled.statusString)
    }

    @objc func darkerSystemColorsStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .darkerSystemColors, statusString: self.featureStatusesProvider.isDarkerSystemColorsEnabled.statusString)
    }

    @objc func guidedAccessStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .guidedAccess, statusString: self.featureStatusesProvider.isGuidedAccessEnabled.statusString)
    }

    @objc func largerTextStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .largerText, statusString: self.featureStatusesProvider.largerTextCatagory.stringValue)
    }

    @objc func shakeToUndoStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .shakeToUndo, statusString: self.featureStatusesProvider.isShakeToUndoEnabled.statusString)
    }

    @objc func speakScreenStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .speakScreen, statusString: self.featureStatusesProvider.isSpeakScreenEnabled.statusString)
    }

    @objc func speakSelectionStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .speakSelection, statusString: self.featureStatusesProvider.isSpeakSelectionEnabled.statusString)
    }
    #endif

    #if os(iOS) || os(tvOS)
    @objc func boldTextStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .boldText, statusString: self.featureStatusesProvider.isBoldTextEnabled.statusString)
    }

    @objc func closedCaptioningStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .closedCaptioning, statusString: self.featureStatusesProvider.isClosedCaptioningEnabled.statusString)
    }

    @objc func grayscaleStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .grayscale, statusString: self.featureStatusesProvider.isGrayscaleEnabled.statusString)
    }

    @objc func invertColorsStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .invertColors, statusString: self.featureStatusesProvider.isInvertColorsEnabled.statusString)
    }

    @objc func monoAudioStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .monoAudio, statusString: self.featureStatusesProvider.isMonoAudioEnabled.statusString)
    }

    @objc func switchControlStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .switchControl, statusString: self.featureStatusesProvider.isSwitchControlEnabled.statusString)
    }

    @objc func reduceTransparencyStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .reduceTransparency, statusString: self.featureStatusesProvider.isReduceTransparencyEnabled.statusString)
    }
    #endif

    @objc func reduceMotionStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .reduceMotion, statusString: self.featureStatusesProvider.isReduceMotionEnabled.statusString)
    }

    @objc func voiceOverStatusChanged(notification: NSNotification) {
        self.postNotification(withFeature: .voiceOver, statusString: self.featureStatusesProvider.isVoiceOverEnabled.statusString)
    }
}
