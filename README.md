<center><img src="https://user-images.githubusercontent.com/1390908/41822361-a14fafd2-77ee-11e8-8aa6-f18960566d0c.png" width="400">
</center>

---
[![Awesome](https://camo.githubusercontent.com/13c4e50d88df7178ae1882a203ed57b641674f94/68747470733a2f2f63646e2e7261776769742e636f6d2f73696e647265736f726875732f617765736f6d652f643733303566333864323966656437386661383536353265336136336531353464643865383832392f6d656469612f62616467652e737667)](https://github.com/vsouza/awesome-ios#accessibility)
[![Build Status](https://app.bitrise.io/app/bffa0ab34e532968/status.svg?token=brzakeKmTQGYMdW-lNmClg&branch=develop)](https://app.bitrise.io/app/bffa0ab34e532968)
![Swift](https://img.shields.io/badge/swift-5.0-red.svg)
![Platforms](https://img.shields.io/cocoapods/p/Capable.svg)
[![Cocoapods compatible](https://img.shields.io/cocoapods/v/Capable.svg)](https://cocoapods.org/pods/Capable)
![SPM](https://img.shields.io/badge/SPM-compatible-ff59b4)
[![Carthage compatible](https://img.shields.io/badge/carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/chrs1885/Capable/branch/develop/graph/badge.svg)](https://codecov.io/gh/chrs1885/Capable)
[![Twitter](https://img.shields.io/badge/twitter-%40chr__wendt-58a1f2.svg)](https://twitter.com/chr_wendt)

# Accessibility for iOS, macOS, tvOS, and watchOS

## 🎉 What's new in Capable 2.0 🎉

Here are the most important changes:

* 🏛 New framework architecture and project structure that makes contributing support for upcoming accessibility settings easier.
* 🎯 Focus on an unified API for Apple accessibility settings: While support for scalable fonts & handicap grouping was dropped entirely, the APIs for calculating high contrast color pairs based on WCAG 2.1 success criteria has moved to it's own repository [WCAG-Colors](https://github.com/chrs1885/WCAG-Colors).
* ✅ Support for new accessibility APIs.

### Research & React

* [Get the user's accessibility settings](#accessibility-status)
* [Get status of accessibility feature](#accessibility-status)
* [Get notified about any changes](#notifications)
* [Send status with your favorite analytics SDK](#send-status)

Have you ever thought about improving accessibility within your apps to gain your user base instead of spending a lot of time implementing features no-one really ever asked for? Most of us did, however there has never been an easy way to tell if anyone benefits from that. What if there was a simple way to figure out if there's a real need to support accessibility right now. Or even better, which disability exists most across your user base.

While Apple's accessibility API are different across all platforms and might be located in a variety of system frameworks,
Capable offers a unified and centralized API to get the current status of accessibility settings. This info can be sent to your analytics backend to learn, if people with specific handicaps are blocked from doing certain actions within your app. Furthermore, this data will help you to prioritize accessibility work.

Once you've figured out that users with specific handicaps get stuck at a certain stage, you can make use of various Capable APIs to enable/disable accessibility support based on the user's accessibility settings.

## Documentation

Capable offers a whole lot of features along with a bunch of configurations. To find more about how to use them inside the [documentation](Documentation/Reference/README.md) section.

## Installation

There are currently four different ways to integrate Capable into your apps.

### CocoaPods

```ruby
use_frameworks!

target 'MyApp' do
  pod 'Capable'
end
```

### Carthage

```ruby
github "chrs1885/Capable"
```

### Swift Package Manager

```ruby
dependencies: [
    .package(url: "https://github.com/chrs1885/Capable.git", from: "2.0.0")
]
```

### Manually

Simply drop `Capable.xcodeproj` into your project. Also make sure to add
`Capable.framework` to your app’s embedded frameworks found in the General tab of your main project.

## Usage

### Register for (specific) accessibility settings

Firstly, you need to import the Capable framework in your class by adding the following import statement:

```swift
import Capable
```

There are two different ways to initialize the framework instance. You can either set it up to consider all accessibility features

```swift
let capable = Capable()
```

or by passing in only specific feature names

```swift
let capable = Capable(withFeatures: [.largerText, .boldText, .shakeToUndo])
```

You can find a list of all accessibility features available on each platform in the [accessibility feature overview](#accessibility-feature-overview) section.

<a id="accessibility-status"></a> 
### Get accessibility status

If you are interested in a specific accessibility feature, you can retrieve its current status as follows:

```swift
let capable = Capable()
let isVoiceOverEnabled: Bool = capable.isFeatureEnable(feature: .voiceOver)
```

To get a dictionary of all features, that the `Capable` instance has been initialized with you can use:

```swift
let capable = Capable()
let statusMap = capable.statusMap
```

This will return each feature name (key) along with its current value as described in the [accessibility feature overview](#accessibility-feature-overview) section.

<a id="send-status"></a> 
### Send accessibility status

The `statusMap` object is compatible with most analytic SDK APIs. Here's a quick example of how to send your data along with user properties or custom events.

```swift
func sendMetrics() {
    let statusMap = self.capable.statusMap
    let eventName = "Capable features received"
    
    // App Center
    MSAnalytics.trackEvent(eventName, withProperties: statusMap)
    
    // Firebase
    Analytics.logEvent(eventName, parameters: statusMap)
    
    // Fabric
    Answers.logCustomEvent(withName: eventName, customAttributes: statusMap)
}
```

<a id="notifications"></a> 
### Listen for settings changes

After initialization, notifications for all features that have been registered can be retrieved. To react to changes, you need to add your class as an observer as follows:

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(self.featureStatusChanged),
    name: .CapableFeatureStatusDidChange,
    object: nil)
```

Inside your `featureStatusChanged` you can parse the specific feature and value:

```swift
@objc private func featureStatusChanged(notification: NSNotification) {
    if let featureStatus = notification.object as? FeatureStatus {
        let feature = featureStatus.feature
        let currentValue = featureStatus.statusString
    }
}
```

<a id="feature-overview"></a> 
### Accessibility feature overview

The following table contains all features that are available:

✅ API provided by Apple and fully supported by Capable

☑️ API provided by Apple (status only, no notification) and fully supported by Capable

❌ API provided by Apple but not supported by Capable due to missing system settings entry.

|                               | iOS          | macOS | tvOS         | watchOS |
| ----------------------------- |:-------------| :-----| :------------| :-------|
| .assistiveTouch               | ✅           |       | ❌           |        |
| .boldText                     | ✅           |       | ✅           | ☑️     |
| .buttonShapes                 | ✅ *(iOS14)* |       | ❌           |        |
| .closedCaptioning             | ✅           |       | ✅           |        |
| .darkerSystemColors           | ✅           |       | ❌           |        |
| .differentiateWithoutColor    | ✅ *(iOS13)* | ✅    | ❌           |        |
| .fullKeyboardAccess           |              | ☑️    |              |        |
| .grayscale                    | ✅           |       | ✅           |        |
| .guidedAccess                 | ✅           |       | ❌           |        |
| .hearingDevice                | ✅           |       |              |        |
| .increaseContrast             |              | ✅    |              |        |
| .invertColors                 | ✅           | ✅    | ✅           |        |
| .largerText                   | ✅           |       | ❌           | ☑️     |
| .monoAudio                    | ✅           |       | ✅           |        |
| .onOffSwitchLabels            | ✅ *(iOS13)* |       | ❌           |        |
| .prefersCrossFadeTransitions  | ✅ *(iOS14)* |       | ❌           |        |
| .reduceMotion                 | ✅           | ✅    | ✅           | ✅     |
| .reduceTransparency           | ✅           | ✅    | ✅           |        |
| .shakeToUndo                  | ✅           |       | ❌           |        |
| .speakScreen                  | ✅           |       | ❌           |        |
| .speakSelection               | ✅           |       | ❌           |        |
| .switchControl                | ✅           | ✅    | ✅           |        |
| .videoAutoplay                | ✅ *(iOS13)* |       | ✅ *(iOS13)* |         |
| .voiceOver                    | ✅           | ✅    | ✅           | ✅     |

While most features can only have a `statusMap` value set to **enabled** or **disabled**, the `.largerText` and `.hearingDevice` feature do offer specific values:

#### LargerText

##### iOS

* XS
* S
* M *(default)*
* L
* XL
* XXL
* XXXL
* Accessibility M
* Accessibility L
* Accessibility XL
* Accessibility XXL
* Accessibility XXXL
* Unknown

##### watchOS

* XS
* S *(default watch with 38mm)*
* L *(default watch with 42mm)*
* XL
* XXL
* XXXL
* Unknown

#### HearingDevice

* both
* left
* right
* disabled

<a id="logging"></a> 
### Logging with OSLog

The Capable framework provides a logging mechanism that lets you keep track of what's going on under the hood. You'll get information regarding your current setup, warnings about anything that might cause issues further on, and errors that will lead to misbehavior. 

By default, all messages will be logged automatically by using Apple's [Unified Logging System](https://developer.apple.com/documentation/os/logging). However, it also integrates with your specific logging environment by providing a custom closure that will be called instead. For example, you may want to send all errors coming from the Capable framework to your analytics service:

```swift
// Send error messages to your data backend
Capable.onLog = { message, logType in
    if logType == OSLogType.error {
        sendLog("Capable Framework: \(message)")
    }
}
```

Furthermore, you can specify the minimum log level that should be considered when logging messages:

```swift
// Configure logger to only log warnings and errors (.default, .error, and .fault)
Capable.minLogType = OSLogType.default
```

Here's a list of the supported log types, their order, and what kind of messages they are used for:

| OSLogType | Usage                                                        |
| ----------|:-------------------------------------------------------------|
| .debug    | Verbose logging **\***                                       |
| .info     | Information regarding the framework setup and status changes |
| .default  | Warnings that may lead to unwanted behavior                  |
| .error    | Errors caused by the framework                               |
| .fault    | Errors caused by the framework due to system issues **\***   |

*\* Currently not being used by the framework when logging messages.*

## Resources

* [Apple - WWDC Session Videos](https://developer.apple.com/videos/frameworks/accessibility/
)
* [Apple - Accessibility for Developers](https://developer.apple.com/accessibility/)

## Contributions

We'd love to see you contributing to this project by proposing or adding features, reporting bugs, or spreading the word. Please have a quick look at our [contribution guidelines](./.github/CONTRIBUTING.md).

## License

Capable is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
