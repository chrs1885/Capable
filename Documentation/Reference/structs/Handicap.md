**STRUCT**

# `Handicap`

```swift
public struct Handicap: Equatable
```

> Model class that groups a number of `CapableFeature`s to represent a user's handicap.

## Properties
### `features`

```swift
public private(set) var features: [CapableFeature]
```

> A list of `CapableFeature`s that are expected to be enabled if a user has this handicap.

### `name`

```swift
public private(set) var name: String
```

> The name of the `Handicap` that can be used to uniquely identify the `Handicap`. This name is also used inside the status map.

### `enabledIf`

```swift
public private(set) var enabledIf: HandicapEnabledMode
```

> This mode defines whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.

## Methods
### `init(features:name:enabledIf:)`

```swift
public init(features: [CapableFeature], name: String, enabledIf: HandicapEnabledMode)
```

> Initializes a new `Handicap` object.
>
> - Parameters:
> - features: A list of features that are expected to be enabled if a user has this handicap.
> - name: The name of the `Handicap` that can be used to uniquely identify the `Handicap`. This name is also used inside the status map.
> - enabledIf: This mode defines whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.
