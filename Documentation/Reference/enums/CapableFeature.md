**ENUM**

# `CapableFeature`

```swift
public enum CapableFeature: String, CaseIterable
```

> An enum specifying all features available on the current platform.

## Cases
### `assistiveTouch`

> Menu that helps people with motor skill impairments to do certain actions or gestures by using a single tap.

### `darkerSystemColors`

> Enhances text contrast.

### `guidedAccess`

> Restricts access to certain features of a single app to keep the user focused.

### `hearingDevicePairedEar`

> Pairing status of a hearing aid.

### `onOffSwitchLabels`

> Displays on/off labels for UISwitch controls.

### `shakeToUndo`

> Deletes the last command by shaking the phone.

### `speakScreen`

> Reads out the content of the current screen.

### `speakSelection`

> Reads out the selected content.

### `fullKeyboardAccess`

```swift
case fullKeyboardAccess
```

> Enables users to navigate through items of the screen without having to use a mouse.

### `increaseContrast`

```swift
case increaseContrast
```

> Increases contrast to make out text and interface elements.

### `closedCaptioning`

> Displays subtitles when playing videos.

### `grayscale`

> Makes the display more readable for color blind people by using gray tones instead of colors.

### `monoAudio`

> Merges stereo audio channels to help users that are hard of hearing or deaf in one ear.

### `videoAutoplay`

> Allows users who are sensitive to motion to disable automatic video playback.

### `largerText`

> Increases legibility by making fonts bigger.

### `differentiateWithoutColor`

```swift
case differentiateWithoutColor
```

> Helps color blind users to differentiate settings differently, e.g. by using shapes rather than colors.

### `invertColors`

```swift
case invertColors
```

> Helps people with low vision, color blindness, or sensitivity to brightness to read the display content.

### `reduceTransparency`

```swift
case reduceTransparency
```

> Removes transparency from layers to make them readable for users with visual impairment.

### `switchControl`

```swift
case switchControl
```

> Allows users with limited mobility to control their device with the help of ability switches and other adaptive devices.

### `boldText`

> Increases legibility by making fonts heavier.

### `reduceMotion`

```swift
case reduceMotion
```

> Reduces animations to help users with motion sickness and epilepsy issues.

### `voiceOver`

```swift
case voiceOver
```

> The screen reader available on Apple platforms.
