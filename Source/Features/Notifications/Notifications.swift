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
            displayOptionStatuses = [CapableFeature: Bool]()
            keyValueObservations = [NSKeyValueObservation]()
        #endif
    }

    static var systemNotificationCenter: NotificationCenter {
        #if os(OSX)
            return NSWorkspace.shared.notificationCenter
        #else
            return NotificationCenter.default
        #endif
    }

    func postNotification(withFeature _: CapableFeature, statusString _: String) {
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
                addObserver(forNotification: UIAccessibility.assistiveTouchStatusDidChangeNotification, selector: #selector(assistiveTouchStatusChanged))
            }
            if features.contains(.darkerSystemColors) {
                addObserver(forNotification: UIAccessibility.darkerSystemColorsStatusDidChangeNotification, selector: #selector(darkerSystemColorsStatusChanged))
            }
            if features.contains(.differentiateWithoutColor) {
                if #available(iOS 13.0, *) {
                    addObserver(forNotification: NSNotification.Name(rawValue: UIAccessibility.differentiateWithoutColorDidChangeNotification), selector: #selector(self.differentiateWithoutColorStatusChanged))
                }
            }
            if features.contains(.guidedAccess) {
                addObserver(forNotification: UIAccessibility.guidedAccessStatusDidChangeNotification, selector: #selector(guidedAccessStatusChanged))
            }
            if features.contains(.hearingDevice) {
                addObserver(forNotification: UIAccessibility.hearingDevicePairedEarDidChangeNotification, selector: #selector(guidedAccessStatusChanged))
            }
            if features.contains(.largerText) {
                addObserver(forNotification: UIContentSizeCategory.didChangeNotification, selector: #selector(largerTextStatusChanged))
            }
            if features.contains(.onOffSwitchLabels) {
                if #available(iOS 13.0, *) {
                    addObserver(forNotification: UIAccessibility.onOffSwitchLabelsDidChangeNotification, selector: #selector(self.onOffSwitchLabelsStatusChanged))
                }
            }
            if features.contains(.shakeToUndo) {
                addObserver(forNotification: UIAccessibility.shakeToUndoDidChangeNotification, selector: #selector(shakeToUndoStatusChanged))
            }
            if features.contains(.speakScreen) {
                addObserver(forNotification: UIAccessibility.speakScreenStatusDidChangeNotification, selector: #selector(speakScreenStatusChanged))
            }
            if features.contains(.speakSelection) {
                addObserver(forNotification: UIAccessibility.speakSelectionStatusDidChangeNotification, selector: #selector(speakSelectionStatusChanged))
            }

        #endif

        #if os(iOS) || os(tvOS)

            if features.contains(.boldText) {
                addObserver(forNotification: UIAccessibility.boldTextStatusDidChangeNotification, selector: #selector(boldTextStatusChanged))
            }
            if features.contains(.closedCaptioning) {
                addObserver(forNotification: UIAccessibility.closedCaptioningStatusDidChangeNotification, selector: #selector(closedCaptioningStatusChanged))
            }
            if features.contains(.grayscale) {
                addObserver(forNotification: UIAccessibility.grayscaleStatusDidChangeNotification, selector: #selector(grayscaleStatusChanged))
            }
            if features.contains(.invertColors) {
                addObserver(forNotification: UIAccessibility.invertColorsStatusDidChangeNotification, selector: #selector(invertColorsStatusChanged))
            }
            if features.contains(.monoAudio) {
                addObserver(forNotification: UIAccessibility.monoAudioStatusDidChangeNotification, selector: #selector(monoAudioStatusChanged))
            }
            if features.contains(.switchControl) {
                addObserver(forNotification: UIAccessibility.switchControlStatusDidChangeNotification, selector: #selector(switchControlStatusChanged))
            }
            if features.contains(.reduceMotion) {
                addObserver(forNotification: UIAccessibility.reduceMotionStatusDidChangeNotification, selector: #selector(reduceMotionStatusChanged))
            }
            if features.contains(.reduceTransparency) {
                addObserver(forNotification: UIAccessibility.reduceTransparencyStatusDidChangeNotification, selector: #selector(reduceTransparencyStatusChanged))
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
                    addObserver(forNotification: Notification.Name(UIAccessibilityVoiceOverStatusChanged), selector: #selector(voiceOverStatusChanged))
                }
            }

        #endif

        #if os(watchOS)

            if #available(watchOS 4.0, *), features.contains(.reduceMotion) {
                addObserver(forNotification: .WKAccessibilityReduceMotionStatusDidChange, selector: #selector(self.reduceMotionStatusChanged))
            }
            if features.contains(.voiceOver) {
                addObserver(forNotification: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged), selector: #selector(voiceOverStatusChanged))
            }

        #endif

        #if os(OSX)

            if features.contains(.differentiateWithoutColor) {
                displayOptionStatuses[.differentiateWithoutColor] = featureStatusesProvider.isDifferentiateWithoutColorEnabled
            }
            if features.contains(.increaseContrast) {
                displayOptionStatuses[.increaseContrast] = featureStatusesProvider.isIncreaseContrastEnabled
            }
            if features.contains(.invertColors) {
                displayOptionStatuses[.invertColors] = featureStatusesProvider.isInvertColorsEnabled
            }
            if features.contains(.reduceMotion) {
                displayOptionStatuses[.reduceMotion] = featureStatusesProvider.isReduceMotionEnabled
            }
            if features.contains(.reduceTransparency) {
                displayOptionStatuses[.reduceTransparency] = featureStatusesProvider.isReduceTransparencyEnabled
            }

            addObserver(forNotification: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification, selector: #selector(displayOptionsChanged), object: NSWorkspace.shared)

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

        Logger.info("Registered notification for features \(features.map { $0.rawValue }.joined(separator: ", "))")
    }

    // swiftlint:enable cyclomatic_complexity
}

// MARK: - Handle notifications

extension Notifications {
    func addObserver(forNotification notificationName: NSNotification.Name, selector: Selector, object: Any? = nil) {
        systemNotificationCenter.addObserver(
            self,
            selector: selector,
            name: notificationName,
            object: object
        )
    }

    #if os(iOS)

        @objc func assistiveTouchStatusChanged() {
            postNotification(withFeature: .assistiveTouch, statusString: featureStatusesProvider.isAssistiveTouchEnabled.statusString)
        }

        @objc func darkerSystemColorsStatusChanged() {
            postNotification(withFeature: .darkerSystemColors, statusString: featureStatusesProvider.isDarkerSystemColorsEnabled.statusString)
        }

        @objc func differentiateWithoutColorStatusChanged() {
            postNotification(withFeature: .differentiateWithoutColor, statusString: featureStatusesProvider.isDifferentiateWithoutColorEnabled.statusString)
        }

        @objc func guidedAccessStatusChanged() {
            postNotification(withFeature: .guidedAccess, statusString: featureStatusesProvider.isGuidedAccessEnabled.statusString)
        }

        @objc func hearingDeviceStatusChanged() {
            postNotification(withFeature: .hearingDevice, statusString: featureStatusesProvider.hearingDevicePairedEar.statusString)
        }

        @objc func largerTextStatusChanged() {
            postNotification(withFeature: .largerText, statusString: featureStatusesProvider.largerTextCatagory.stringValue)
        }

        @objc func onOffSwitchLabelsStatusChanged() {
            postNotification(withFeature: .onOffSwitchLabels, statusString: featureStatusesProvider.isOnOffSwitchLabelsEnabled.statusString)
        }

        @objc func shakeToUndoStatusChanged() {
            postNotification(withFeature: .shakeToUndo, statusString: featureStatusesProvider.isShakeToUndoEnabled.statusString)
        }

        @objc func speakScreenStatusChanged() {
            postNotification(withFeature: .speakScreen, statusString: featureStatusesProvider.isSpeakScreenEnabled.statusString)
        }

        @objc func speakSelectionStatusChanged() {
            postNotification(withFeature: .speakSelection, statusString: featureStatusesProvider.isSpeakSelectionEnabled.statusString)
        }

    #endif

    #if os(iOS) || os(tvOS)

        @objc func boldTextStatusChanged() {
            postNotification(withFeature: .boldText, statusString: featureStatusesProvider.isBoldTextEnabled.statusString)
        }

        @objc func closedCaptioningStatusChanged() {
            postNotification(withFeature: .closedCaptioning, statusString: featureStatusesProvider.isClosedCaptioningEnabled.statusString)
        }

        @objc func grayscaleStatusChanged() {
            postNotification(withFeature: .grayscale, statusString: featureStatusesProvider.isGrayscaleEnabled.statusString)
        }

        @objc func invertColorsStatusChanged() {
            postNotification(withFeature: .invertColors, statusString: featureStatusesProvider.isInvertColorsEnabled.statusString)
        }

        @objc func monoAudioStatusChanged() {
            postNotification(withFeature: .monoAudio, statusString: featureStatusesProvider.isMonoAudioEnabled.statusString)
        }

        @objc func reduceTransparencyStatusChanged() {
            postNotification(withFeature: .reduceTransparency, statusString: featureStatusesProvider.isReduceTransparencyEnabled.statusString)
        }

        @objc func videoAutoplayStatusChanged() {
            postNotification(withFeature: .videoAutoplay, statusString: featureStatusesProvider.isVideoAutoplayEnabled.statusString)
        }

    #endif

    #if os(iOS) || os(tvOS) || os(OSX)

        @objc func switchControlStatusChanged() {
            postNotification(withFeature: .switchControl, statusString: featureStatusesProvider.isSwitchControlEnabled.statusString)
        }

    #endif

    #if os(OSX)

        @objc func displayOptionsChanged() {
            for feature in displayOptionStatuses.keys {
                let newValue = featureStatusesProvider.isFeatureEnabled(feature: feature)
                let oldValue = displayOptionStatuses[feature]

                if newValue != oldValue {
                    displayOptionStatuses[feature] = newValue
                    postNotification(withFeature: feature, statusString: newValue.statusString)
                }
            }
        }

    #endif

    @objc func reduceMotionStatusChanged() {
        postNotification(withFeature: .reduceMotion, statusString: featureStatusesProvider.isReduceMotionEnabled.statusString)
    }

    @objc func voiceOverStatusChanged() {
        postNotification(withFeature: .voiceOver, statusString: featureStatusesProvider.isVoiceOverEnabled.statusString)
    }
}
