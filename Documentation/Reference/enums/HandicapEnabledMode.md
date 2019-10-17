**ENUM**

# `HandicapEnabledMode`

```swift
public enum HandicapEnabledMode: String
```

> This enum defines several modes which describe whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.

## Cases
### `oneFeatureEnabled`

```swift
case oneFeatureEnabled
```

> The `Handicap`'s status is enabled if one of its features is currently set to **enabled**.

### `allFeaturesEnabled`

```swift
case allFeaturesEnabled
```

> The `Handicap`'s status is enabled if all its features are currently set to **enabled**.
