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

Check out the *Example.xcworkspace* to get a quick overview:

![Example project overview](./Documentation/Images/features_example_app.png)

### 1) Research: Do I need to care about accessibility?

* [Get the user's accessibility settings](#accessibility-status)
* [Define handicaps by grouping accessibility features](#handicaps)
* [Send status with your favorite analytics SDK](#send-status)

Have you ever thought about adopting accessibility features within you apps to gain your user base instead of spending a lot of time implementing features no-one really ever asked for? 

Most of us did, however there has never been an easy way to tell if anyone benefits from that. Adjusting layouts to be usable for people with low vision can be quite complex in some situations and tracking the user's accessibility settings adds a lot of boilerplate code to your app.

What if there was a simple way to figure out if there's a real need to support accessibility right now. Or even better, which disability exists most across your user base.

### 2) React: Improve problematic screens

* [Get status of accessibility feature](#accessibility-status)
* [Get notified about any changes](#notifications)
* [Calculate high contrast WCAG compliant colors](#colors)
* [Calculate high contrast image text colors](#captions)
* [Use dynamic type with custom fonts](#dynamic-type)

Once you've figured out that users with specific handicaps get stuck at a certain stage, you can make use of various Capable APIs to enable/disable accessibility support based on the user's accessibility settings or improve texts and colors used within your apps. Go back to step 1 to proof that the work helped users to succeed using your app.

### 3) Fault diagnosis

Each Capable feature is backed by the built-in logging system, which will keep you in the loop about what might have been going wrong. Even if you are using your own logging solution, the Capable logger is fully compatible with it!

* [Custom logging with OSLog](#logging)

## Documentation

Capable offers a whole lot of features along with a bunch of configurations. To find more about how to use them inside the [documentation](Documentation/Reference/README.md) section.

## Installation

There are currently four different ways to integrate Capable into your apps.

### CocoaPods

```ruby
use_frameworks!

target 'MyApp' do

  # all features + color and font extensions
  pod 'Capable'

  # all features, but exclude color and font extensions
  pod 'Capable/Features'
  
  # color extensions only
  pod 'Capable/Colors'

  # font extensions only
  pod 'Capable/Fonts'
end
```

### Carthage

```ruby
github "chrs1885/Capable"
```

### Swift Package Manager

```ruby
dependencies: [
    .package(url: "https://github.com/chrs1885/Capable.git", from: "1.1.4")
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

<a id="handicaps"></a> 
### Handicaps - grouped accessibility features

You can also group accessibility features to represent a specific handicap:

```swift
// Define a set of features that represent a handicap
let features: [CapableFeature] = [.voiceOver, .speakScreen, .speakSelection]

// Use the Handicap object to group them
let blindness = Handicap(features: features, name: "Blindness", enabledIf: .allFeaturesEnabled)

// Initialize the framework instance by providing the Handicap
let capable = Capable(withHandicaps: [blindness])
```

The value of the `name` parameter will be used inside the `statusMap` provided by the Capable framework instance. Based on the value of `enabledIf`, you can specify if all features need to be set to **enabled** in order to set the Handicap to **enabled** as well.
 
Just like accessibility features, the `Handicap` type works great with [notifications](#notifications). 

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

If your framework instance has been set up with `Handicap`s instead, you can use the `CapableHandicapStatusDidChange ` notification:

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(self.handicapStatusChanged),
    name: .CapableHandicapStatusDidChange,
    object: nil)
```

Once the notification has been sent, you can parse the `Handicap`and its current status as follows:

```swift
@objc private func handicapStatusChanged(notification: NSNotification) {
    if let handicapStatus = notification.object as? HandicapStatus {
        let handicap = handicapStatus.handicap
        let currentValue = handicapStatus.statusString
    }
}
```

Please note that when using notifications with `Handicap`s on macOS or watchOS, you might not get notified about all changes since [not all accessibility features do support notifications](#feature-overview), yet. 

<a id="colors"></a> 
### High contrast colors (Capable UIColor/NSColor extension)

The *Web Content Accessibility Guidelines* (WCAG) define minimum contrast ratios for a text and its background. The Capable framework extends `UIColor` and `NSColor` with functionality to use WCAG conformant colors within your apps to help people with visual disabilities to perceive content.

Internally, the provided colors will be mapped to an equivalent of the sRGB color space. All functions will return `nil` and [log warnings](#logging) with further info in case any input color couldn't be converted. Also note that semi-transparent text colors will be blended with its background color. However, the alpha value of semi-transparent background colors will be ignored since the underlying color can't be determined.

#### Text colors
Get a high contrast text color for a given background color as follows:

```swift
let textColor = UIColor.getTextColor(onBackgroundColor: UIColor.red)!
```

This will return the text color with the highest possible contrast (black/white). Alternatively, you can define a list of possible text colors as well as a required conformance level. Since the WCAG requirements for contrast differ in text size and weight, you also need to provide the font used for the text. The following will return the first text color that satisfies the required conformance level (*AA* by default).

```swift
let textColor = UIColor.getTextColor(
    fromColors: [UIColor.red, UIColor.yellow],
    withFont: myLabel.font,
    onBackgroundColor: view.backgroundColor,
    conformanceLevel: .AA
)!
```

#### Background colors

This will also work the other way round. If you are looking for a high contrast background color:

```swift
let backgroundColor = UIColor.getBackgroundColor(forTextColor: UIColor.red)!

// or

let backgroundColor = UIColor.getBackgroundColor(
    fromColors: [UIColor.red, UIColor.yellow],
    forTextColor: myLabel.textColor,
    withFont: myLabel.font,
    conformanceLevel: .AA
)!
```

<a id="captions"></a> 
#### Image captions (iOS/tvOS/macOS)

Get a high contrast text color for any given background image as follows:

```swift
let textColor = UIColor.getTextColor(onBackgroundImage: myImage imageArea: .full)!
```

This will return the text color with the highest possible contrast (black/white) for a specific image area. 

Alternatively, you can define a list of possible text colors as well as a required conformance level. Since the WCAG requirements for contrast differ in text size and weight, you also need to provide the font used for the text. The following will return the first text color that satisfies the required conformance level (*AA* by default).

```swift
let textColor = UIColor.getTextColor(
    fromColors: [UIColor.red, UIColor.yellow],
    withFont: myLabel.font,
    onBackgroundImage: view.backgroundColor,
    imageArea: topLeft,
    conformanceLevel: .AA
)!
```

You can find an overview of all image areas available in the [documentation](Documentation/Reference/enums/ImageArea.md).

#### Calculating contrast ratios & WCAG conformance levels

The contrast ratio of two opaque colors can be calculated as well:

```swift
let contrastRatio: CGFloat = UIColor.getContrastRatio(forTextColor: UIColor.red, onBackgroundColor: UIColor.yellow)!
```

Once the contrast ratio has been determined, you can check the resulting conformance level specified by WCAG as follows:

```swift
let passedConformanceLevel = ConformanceLevel(contrastRatio: contrastRatio, fontSize: myLabel.font.pointSize, isBoldFont: true)
```

Here's an overview of available conformance levels:

| Level   | Contrast ratio                 | Font size               |
| --------|:-------------------------------|:------------------------|
| .A      | *Not specified for text color* | -                       |
| .AA     | 3.0                            | 18.0 (or 14.0 and bold) |
|         | 4.5                            | 14.0                    |
| .AAA    | 4.5                            | 18.0 (or 14.0 and bold) |
| .AAA    | 7.0                            | 14.0                    |
| .failed | *.AA/.AAA not satisfied*       | -                       |

<a id="dynamic-type"></a> 
### Dynamic Type with custom fonts (Capable UIFont extension)

Supporting Dynamic Type along with different OS versions such as iOS 10 and iOS 11 (watchOS 3 and watchOS 4) can be a huge pain, since both versions provide different APIs.

Capable easily auto scales system fonts as well as your custom fonts by providing one line of code:

```swift
let myLabel = UILabel(frame: frame)

// Scalable custom font
let myCustomFont = UIFont(name: "Custom Font Name", size: defaultFontSize)!
myLabel.font = UIFont.scaledFont(for: myCustomFont)

// or
myLabel.font = UIFont.scaledFont(withName: "Custom Font Name", ofSize: defaultFontSize)

// Scalable system font
myLabel.font = UIFont.scaledSystemFont(ofSize: defaultFontSize)

// Scalable italic system font
myLabel.font = UIFont.scaledItalicSystemFont(ofSize: defaultFontSize)

// Scalable bold system font
myLabel.font = UIFont.scaledBoldSystemFont(ofSize: defaultFontSize)
```

While these extension APIs are available on tvOS as well, setting the font size in the system settings is not supported on this platforms.

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

<a id="feature-overview"></a> 
## Accessibility feature overview

The following table contains all features that are available AND settable on each platform.

|                            | iOS                | macOS                          | tvOS               | watchOS                        |
| -------------------------- |:------------------:| :-----------------------------:| :-----------------:| :-----------------------------:|
| .assistiveTouch            | :white_check_mark: |                                |                    |                                |
| .boldText                  | :white_check_mark: |                                | :white_check_mark: | &nbsp;:white_check_mark:**\*** |
| .closedCaptioning          | :white_check_mark: |                                | :white_check_mark: |                                |
| .darkerSystemColors        | :white_check_mark: |                                |                    |                                |
| .differentiateWithoutColor | :white_check_mark: | :white_check_mark:             |                    |                                |
| .fullKeyboardAccess        |                    | &nbsp;:white_check_mark:**\*** |                    |                                |
| .grayscale                 | :white_check_mark: |                                | :white_check_mark: |                                |
| .guidedAccess              | :white_check_mark: |                                |                    |                                |
| .hearingDevice             | :white_check_mark: |                                |                    |                                |
| .increaseContrast          |                    | :white_check_mark:             |                    |                                |
| .invertColors              | :white_check_mark: | :white_check_mark:             | :white_check_mark: |                                |
| .largerText                | :white_check_mark: |                                |                    | &nbsp;:white_check_mark:**\*** |
| .monoAudio                 | :white_check_mark: |                                | :white_check_mark: |                                |
| .onOffSwitchLabels         | :white_check_mark: |                                |                    |                                |
| .reduceMotion              | :white_check_mark: | :white_check_mark:             | :white_check_mark: | :white_check_mark:             |
| .reduceTransparency        | :white_check_mark: | :white_check_mark:             | :white_check_mark: |                                |
| .shakeToUndo               | :white_check_mark: |                                |                    |                                |
| .speakScreen               | :white_check_mark: |                                |                    |                                |
| .speakSelection            | :white_check_mark: |                                |                    |                                |
| .switchControl             | :white_check_mark: | :white_check_mark:             | :white_check_mark: |                                |
| .videoAutoplay             | :white_check_mark: |                                | :white_check_mark: |                                |
| .voiceOver                 | :white_check_mark: | :white_check_mark:             | :white_check_mark: | :white_check_mark:             |

*\* Feature status can be read but notifications are not available.*

While most features can only have a `statusMap` value set to **enabled** or **disabled**, the `.largerText` and `.hearingDevice` feature do offer specific values:

### LargerText

#### iOS

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

#### watchOS

* XS
* S *(default watch with 38mm)*
* L *(default watch with 42mm)*
* XL
* XXL
* XXXL
* Unknown

### HearingDevice

* both
* left
* right
* disabled

## Resources

* [Apple - WWDC Session Videos](https://developer.apple.com/videos/frameworks/accessibility/
)
* [Apple - Accessibility for Developers](https://developer.apple.com/accessibility/)
* [WCAG - Understanding WCAG 2.0](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html)

## Contributions

We'd love to see you contributing to this project by proposing or adding features, reporting bugs, or spreading the word. Please have a quick look at our [contribution guidelines](./.github/CONTRIBUTING.md).

## License

Capable is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
