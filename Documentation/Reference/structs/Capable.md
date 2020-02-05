**STRUCT**

# `Capable`

```swift
public struct Capable
```

> This class defines the main interface of the Capable framework.

## Methods
### `init(withFeatures:)`

```swift
public init(withFeatures features: [CapableFeature] = CapableFeature.allCases)
```

> Initializes the framework instance with a specified set of features. If no feature was provided, this defaults to all features available on the current platform.
>
> - Parameters:
>    - features: An optional array containing the features of interest. This will default to all features available on the current platform.

#### Parameters

| Name | Description |
| ---- | ----------- |
| features | An optional array containing the features of interest. This will default to all features available on the current platform. |

### `init(withHandicaps:)`

```swift
public init(withHandicaps handicaps: [Handicap])
```

> Initializes the framework instance with a set of `Handicap`s.
>
> - Parameters:
>    - handicaps: An optional array containing the `Handicaps`s specified by the caller.

#### Parameters

| Name | Description |
| ---- | ----------- |
| handicaps | An optional array containing the `Handicaps`s specified by the caller. |