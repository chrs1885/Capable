<center><img src="https://user-images.githubusercontent.com/1390908/41822361-a14fafd2-77ee-11e8-8aa6-f18960566d0c.png" width="400"></center>

## About

Have you ever thought about adopting accessibilty features within you apps to gain your user base instead of spending a lot of time implementing features noone really ever asked for? 

Most of us did, however there has never been an easy way to tell if anyone benefits from that. Adjusting layouts to be usable for people with low vision can be quite complex in some situations and tracking the user's accessibilty settings adds a lot of boilerplate code to your app.

What if there was a simple way to figure out if there's a real need to support accessibilty right now. Or even better, which disability exists most across your user base.

Check out the Example app to get a quick overview.

## Features
* Get the user's accessibility settings
* Send it with your favorite analytics SDK such as Answers, App Center, Google Analytics, or HockeyApp
* Get notified about any changes
* Use dynamic type with custom fonts by using one line of code without caring about the OS version the user is running on

## Installation

There are currently three different ways to integrate Capable into your apps.

## CocoaPods

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'Capable'
end
```

## Carthage

```ruby
github "chrs1885/Capable"
```

## Manually

Simply drop `Capable.xcodeproj` into your project. Also make sure to add
`Capable.framework` to your app’s embedded frameworks found in the General tab of your main project.

## Usage

### Register for (specific) accessibility settings

Firstly, you need to import the Capable framework in your class by adding the following import statement to your class:

```swift
import Capable
```

There are two different ways to initialize the framework instance. You can either set it up to consider all accessibility features

```swift
let capable = Capable()
```

or by passing in only specific feature names

```swift
let capable = Capable(with: [.LargerText, .BoldText, .ShakeToUndo])
```

You can find all list of all accessibility features available on each platform in the Accessibility feature overview section.

### Listen for settings changes
Aftrer initialization, notifications for all features that have been registered are automatically enabled. To react to changes, you need to add your class as an observer as follows:

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

### Send accessibility status
You can use your favorite analytics SDK to collect the accessibility status of your users:

```swift
func sendMetrics() {
    if let statusMap = self.capable?.statusMap {
        let eventName = "Capable features received"
        
        MSAnalytics.trackEvent(eventName, withProperties: statusMap)
        Analytics.logEvent(eventName, parameters: statusMap)
        Answers.logCustomEvent(withName: eventName, customAttributes: statusMap)
    }
}

```

### Dynamic type with custom fonts

## Accessibility feature overview

The following table contains all features that are available AND setable on each platform.

|                     | iOS                | tvOS               | watchOS            |
| ------------------- |:------------------:| :-----------------:| :-----------------:|
| .AssistiveTouch     | :white_check_mark: |                    |                    |
| .BoldText           | :white_check_mark: | :white_check_mark: |                    |
| .ClosedCaptioning   | :white_check_mark: | :white_check_mark: |                    |
| .DarkerSystemColors | :white_check_mark: |                    |                    |
| .Grayscale          | :white_check_mark: | :white_check_mark: |                    |
| .GuidedAccess.      | :white_check_mark: |                    |                    |
| .InvertColors.      | :white_check_mark: |                    |                    |
| .LargerText.        | :white_check_mark: |                    |                    |
| .MonoAudio          | :white_check_mark: | :white_check_mark: |                    |
| .ReduceMotion       | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| .ReduceTransparency | :white_check_mark: | :white_check_mark: |                    |
| .ShakeToUndo        | :white_check_mark: |                    |                    |
| .SpeakScreen        | :white_check_mark: |                    |                    |
| .SpeakSelection     | :white_check_mark: |                    |                    |
| .SwitchControl      | :white_check_mark: | :white_check_mark: |                    |
| .VoiceOver          | :white_check_mark: | :white_check_mark: | :white_check_mark: |

While most features can only have a status set to **enabled** or **disabled**, the `.LargerText` feature offers the font scale set by the user:

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