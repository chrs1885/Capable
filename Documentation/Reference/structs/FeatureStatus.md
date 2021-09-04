**STRUCT**

# `FeatureStatus`

```swift
public struct FeatureStatus
```

Model class that describes the content of a Capable notification (see `Notification.Name.CapableFeatureStatusDidChange`)

## Properties
### `feature`

```swift
public private(set) var feature: CapableFeature
```

The feature type.

### `statusString`

```swift
public private(set) var statusString: String
```

The feature's status: While most features can only have a status set to **enabled** or **disabled**, the '.largerText` feature offers the font scale set by the user.
