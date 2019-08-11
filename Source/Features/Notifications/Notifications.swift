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

#if os(OSX)
import AppKit
#endif

#if os(watchOS)
import WatchKit
#endif

class Notifications: NSObject, NotificationsProtocol {
    var featureStatusesProvider: FeatureStatusesProviderProtocol
    var targetNotificationCenter: NotificationCenter
    var systemNotificationCenter: NotificationCenter

    #if os(OSX)
    var displayOptionStatuses: [CapableFeature: Bool]
    var keyValueObservations: [NSKeyValueObservation]
    #endif

    required init(featureStatusesProvider: FeatureStatusesProviderProtocol, targetNotificationCenter: NotificationCenter = NotificationCenter.default, systemNotificationCenter: NotificationCenter = Notifications.systemNotificationCenter) {
        self.featureStatusesProvider = featureStatusesProvider
        self.targetNotificationCenter = targetNotificationCenter
        self.systemNotificationCenter = systemNotificationCenter

        #if os(OSX)
        self.displayOptionStatuses = [CapableFeature: Bool]()
        self.keyValueObservations = [NSKeyValueObservation]()
        #endif
    }

    static var systemNotificationCenter: NotificationCenter {
        #if os(OSX)
        return NSWorkspace.shared.notificationCenter
        #else
        return NotificationCenter.default
        #endif
    }

    func postNotification(withFeature feature: CapableFeature, statusString: String) {
        let errorMessage = "Capable.Notifications.postNotification: Function needs to be implemented by its subclass."
        Logger.error(errorMessage)
        fatalError(errorMessage)
    }
}

// MARK: - Register Observers
extension Notifications {

    // swiftlint:disable cyclomatic_complexity
    func enableNotifications(forFeatures features: [CapableFeature]) {

        #if os(iOS)

        if features.contains(.assistiveTouch) {
            addObserver(forNotification: UIAccessibility.assistiveTouchStatusDidChangeNotification, selector: #selector(self.assistiveTouchStatusChanged))
        }
        if features.contains(.darkerSystemColors) {
            addObserver(forNotification: UIAccessibility.darkerSystemColorsStatusDidChangeNotification, selector: #selector(self.darkerSystemColorsStatusChanged))
        }
        if features.contains(.guidedAccess) {
            addObserver(forNotification: UIAccessibility.guidedAccessStatusDidChangeNotification, selector: #selector(self.guidedAccessStatusChanged))
        }
        if features.contains(.hearingDevice) {
            addObserver(forNotification: UIAccessibility.hearingDevicePairedEarDidChangeNotification, selector: #selector(self.guidedAccessStatusChanged))
        }
        if features.contains(.largerText) {
            addObserver(forNotification: UIContentSizeCategory.didChangeNotification, selector: #selector(self.largerTextStatusChanged))
        }
        if features.contains(.shakeToUndo) {
            addObserver(forNotification: UIAccessibility.shakeToUndoDidChangeNotification, selector: #selector(self.shakeToUndoStatusChanged))
        }
        if features.contains(.speakScreen) {
            addObserver(forNotification: UIAccessibility.speakScreenStatusDidChangeNotification, selector: #selector(self.speakScreenStatusChanged))
        }
        if features.contains(.speakSelection) {
            addObserver(forNotification: UIAccessibility.speakSelectionStatusDidChangeNotification, selector: #selector(self.speakSelectionStatusChanged))
        }

        #endif

        #if os(iOS) || os(tvOS)

        if features.contains(.boldText) {
            addObserver(forNotification: UIAccessibility.boldTextStatusDidChangeNotification, selector: #selector(self.boldTextStatusChanged))
        }
        if features.contains(.closedCaptioning) {
            addObserver(forNotification: UIAccessibility.closedCaptioningStatusDidChangeNotification, selector: #selector(self.closedCaptioningStatusChanged))
        }
        if features.contains(.differentiateWithoutColor) {
            if #available(iOS 13.0, tvOS 13.0, *) {
                addObserver(forNotification: NSNotification.Name(rawValue: UIAccessibility.differentiateWithoutColorDidChangeNotification), selector: #selector(self.differentiateWithoutColorStatusChanged))
            }
        }
        if features.contains(.grayscale) {
            addObserver(forNotification: UIAccessibility.grayscaleStatusDidChangeNotification, selector: #selector(self.grayscaleStatusChanged))
        }
        if features.contains(.invertColors) {
            addObserver(forNotification: UIAccessibility.invertColorsStatusDidChangeNotification, selector: #selector(self.invertColorsStatusChanged))
        }
        if features.contains(.monoAudio) {
            addObserver(forNotification: UIAccessibility.monoAudioStatusDidChangeNotification, selector: #selector(self.monoAudioStatusChanged))
        }
        if features.contains(.onOffSwitchLabels) {
            if #available(iOS 13.0, tvOS 13.0, *) {
                addObserver(forNotification: UIAccessibility.onOffSwitchLabelsDidChangeNotification, selector: #selector(self.onOffSwitchLabelsStatusChanged))
            }
        }
        if features.contains(.switchControl) {
            addObserver(forNotification: UIAccessibility.switchControlStatusDidChangeNotification, selector: #selector(self.switchControlStatusChanged))
        }
        if features.contains(.reduceMotion) {
            addObserver(forNotification: UIAccessibility.reduceMotionStatusDidChangeNotification, selector: #selector(self.reduceMotionStatusChanged))
        }
        if features.contains(.reduceTransparency) {
            addObserver(forNotification: UIAccessibility.reduceTransparencyStatusDidChangeNotification, selector: #selector(self.reduceTransparencyStatusChanged))
        }
        if features.contains(.videoAutoplay) {
            if #available(iOS 13.0, tvOS 13.0, *) {
                addObserver(forNotification: UIAccessibility.videoAutoplayStatusDidChangeNotification, selector: #selector(self.videoAutoplayStatusChanged))
            }
        }
        if features.contains(.voiceOver) {
            if #available(iOS 11.0, tvOS 11.0, *) {
                addObserver(forNotification: UIAccessibility.voiceOverStatusDidChangeNotification, selector: #selector(self.voiceOverStatusChanged))
            } else {
                addObserver(forNotification: Notification.Name(UIAccessibilityVoiceOverStatusChanged), selector: #selector(self.voiceOverStatusChanged))
            }
        }

        #endif

        #if os(watchOS)

        if #available(watchOS 4.0, *), features.contains(.reduceMotion) {
            addObserver(forNotification: .WKAccessibilityReduceMotionStatusDidChange, selector: #selector(self.reduceMotionStatusChanged))
        }
        if features.contains(.voiceOver) {
            addObserver(forNotification: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged), selector: #selector(self.voiceOverStatusChanged))
        }

        #endif

        #if os(OSX)

        if features.contains(.differentiateWithoutColor) {
            self.displayOptionStatuses[.differentiateWithoutColor] = self.featureStatusesProvider.isDifferentiateWithoutColorEnabled
        }
        if features.contains(.increaseContrast) {
            self.displayOptionStatuses[.increaseContrast] = self.featureStatusesProvider.isIncreaseContrastEnabled
        }
        if features.contains(.invertColors) {
            self.displayOptionStatuses[.invertColors] = self.featureStatusesProvider.isInvertColorsEnabled
        }
        if features.contains(.reduceMotion) {
            self.displayOptionStatuses[.reduceMotion] = self.featureStatusesProvider.isReduceMotionEnabled
        }
        if features.contains(.reduceTransparency) {
            self.displayOptionStatuses[.reduceTransparency] = self.featureStatusesProvider.isReduceTransparencyEnabled
        }

        addObserver(forNotification: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification, selector: #selector(self.displayOptionsChanged), object: NSWorkspace.shared)

        if features.contains(.switchControl), #available(OSX 10.13, *) {
            let switchControlObservation = NSWorkspace.shared.observe(\NSWorkspace.isSwitchControlEnabled) { _, _ in
                self.switchControlStatusChanged()
            }
            self.keyValueObservations.append(switchControlObservation)
        }
        if features.contains(.voiceOver), #available(OSX 10.13, *) {
            let voiceOverObservation = NSWorkspace.shared.observe(\NSWorkspace.isVoiceOverEnabled) { _, _ in
                self.voiceOverStatusChanged()
            }
            self.keyValueObservations.append(voiceOverObservation)
        }

        #endif

        Logger.info("Registered notification for features \(features.map({ $0.rawValue }).joined(separator: ", "))")
    }
    // swiftlint:enable cyclomatic_complexity
}

// MARK: - Handle notifications
extension Notifications {
    func addObserver(forNotification notificationName: NSNotification.Name, selector: Selector, object: Any? = nil) {
        self.systemNotificationCenter.addObserver(
            self,
            selector: selector,
            name: notificationName,
            object: object)
    }

    #if os(iOS)

    @objc func assistiveTouchStatusChanged() {
        postNotification(withFeature: .assistiveTouch, statusString: self.featureStatusesProvider.isAssistiveTouchEnabled.statusString)
    }

    @objc func darkerSystemColorsStatusChanged() {
        self.postNotification(withFeature: .darkerSystemColors, statusString: self.featureStatusesProvider.isDarkerSystemColorsEnabled.statusString)
    }

    @objc func guidedAccessStatusChanged() {
        self.postNotification(withFeature: .guidedAccess, statusString: self.featureStatusesProvider.isGuidedAccessEnabled.statusString)
    }

    @objc func hearingDeviceStatusChanged() {
        self.postNotification(withFeature: .hearingDevice, statusString: self.featureStatusesProvider.hearingDevicePairedEar.statusString)
    }

    @objc func largerTextStatusChanged() {
        self.postNotification(withFeature: .largerText, statusString: self.featureStatusesProvider.largerTextCatagory.stringValue)
    }

    @objc func shakeToUndoStatusChanged() {
        self.postNotification(withFeature: .shakeToUndo, statusString: self.featureStatusesProvider.isShakeToUndoEnabled.statusString)
    }

    @objc func speakScreenStatusChanged() {
        self.postNotification(withFeature: .speakScreen, statusString: self.featureStatusesProvider.isSpeakScreenEnabled.statusString)
    }

    @objc func speakSelectionStatusChanged() {
        self.postNotification(withFeature: .speakSelection, statusString: self.featureStatusesProvider.isSpeakSelectionEnabled.statusString)
    }

    #endif

    #if os(iOS) || os(tvOS)

    @objc func boldTextStatusChanged() {
        self.postNotification(withFeature: .boldText, statusString: self.featureStatusesProvider.isBoldTextEnabled.statusString)
    }

    @objc func closedCaptioningStatusChanged() {
        self.postNotification(withFeature: .closedCaptioning, statusString: self.featureStatusesProvider.isClosedCaptioningEnabled.statusString)
    }
    
    @objc func differentiateWithoutColorStatusChanged() {
        self.postNotification(withFeature: .differentiateWithoutColor, statusString: self.featureStatusesProvider.isDifferentiateWithoutColorEnabled.statusString)
    }

    @objc func grayscaleStatusChanged() {
        self.postNotification(withFeature: .grayscale, statusString: self.featureStatusesProvider.isGrayscaleEnabled.statusString)
    }

    @objc func invertColorsStatusChanged() {
        self.postNotification(withFeature: .invertColors, statusString: self.featureStatusesProvider.isInvertColorsEnabled.statusString)
    }

    @objc func monoAudioStatusChanged() {
        self.postNotification(withFeature: .monoAudio, statusString: self.featureStatusesProvider.isMonoAudioEnabled.statusString)
    }

    @objc func onOffSwitchLabelsStatusChanged() {
        self.postNotification(withFeature: .onOffSwitchLabels, statusString: self.featureStatusesProvider.isOnOffSwitchLabelsEnabled.statusString)
    }
    
    @objc func reduceTransparencyStatusChanged() {
        self.postNotification(withFeature: .reduceTransparency, statusString: self.featureStatusesProvider.isReduceTransparencyEnabled.statusString)
    }
    
    @objc func videoAutoplayStatusChanged() {
        self.postNotification(withFeature: .videoAutoplay, statusString: self.featureStatusesProvider.isVideoAutoplayEnabled.statusString)
    }

    #endif

    #if os(iOS) || os(tvOS) || os(OSX)

    @objc func switchControlStatusChanged() {
        self.postNotification(withFeature: .switchControl, statusString: self.featureStatusesProvider.isSwitchControlEnabled.statusString)
    }

    #endif

    #if os(OSX)

    @objc func displayOptionsChanged() {
        for feature in self.displayOptionStatuses.keys {
            let newValue = self.featureStatusesProvider.isFeatureEnabled(feature: feature)
            let oldValue = self.displayOptionStatuses[feature]

            if newValue != oldValue {
                self.displayOptionStatuses[feature] = newValue
                self.postNotification(withFeature: feature, statusString: newValue.statusString)
            }
        }
    }

    #endif

    @objc func reduceMotionStatusChanged() {
        self.postNotification(withFeature: .reduceMotion, statusString: self.featureStatusesProvider.isReduceMotionEnabled.statusString)
    }

    @objc func voiceOverStatusChanged() {
        self.postNotification(withFeature: .voiceOver, statusString: self.featureStatusesProvider.isVoiceOverEnabled.statusString)
    }
}
