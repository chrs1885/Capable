**STRUCT**

# `HandicapStatus`

```swift
public struct HandicapStatus
```

> Model class that describes the content of a Capable notification (see `Notification.Name.CapableHandicapStatusDidChange`)

## Properties
### `handicap`

```swift
public private(set) var handicap: Handicap
```

> The `Handicap` that has changed.

### `statusString`

```swift
public private(set) var statusString: String
```

> The `Handicap`'s status (**enabled** or **disabled**). Note that the status depends on the `Handicap`'s `enabledIf` value (see `HandicapEnabledMode`).
