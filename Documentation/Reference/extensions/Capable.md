**EXTENSION**

# `Capable`

## Properties
### `statusMap`

```swift
public var statusMap: [String: String]
```

> The `statusMap` property returns a dictionary of all `CapableFeature`s, that the Capable instance has been initialized with along with their current statuses. This object is compatible with most analytic SDKs such as **Fabric Answers**, **Firebase Analytics**, **AppCenter Analytics**, or **HockeyApp**.
> While most entries can only have a status set to **enabled** or **disabled**, the `.largerText` feature offers the font scale set by the user.

## Methods
### `isFeatureEnabled(feature:)`

```swift
public func isFeatureEnabled(feature: CapableFeature) -> Bool
```

> Provides information regarding the current status of a provided feature.
>
> - Parameters:
>    - feature: The feature of interest.
>
> - Returns: `true` if the given feature has been enabled, otherwise `false`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| feature | The feature of interest. |