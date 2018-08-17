//
//  Handicap.swift
//  Capable
//
//  Created by Christoph Wendt on 15.08.18.
//

/**
 Model class that groups a number of `CapableFeature`s to represent a user's handicap. */
public struct Handicap {

    /// A list of `CapableFeature`s that are expected to be enabled if a user has this handicap.
    public private(set) var features: [CapableFeature]

    /// The name of the `Handicap` that can be used to uniquely identify the `Handicap`. This name is also used inside the status map.
    public private(set) var name: String

    /// This mode defines whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.
    public private(set) var enabledIf: HandicapEnabledMode

    /**
     Initializes a new `Handicap` object.

     - Parameters:
     - features: A list of features that are expected to be enabled if a user has this handicap.
     - name: The name of the `Handicap` that can be used to uniquely identify the `Handicap`. This name is also used inside the status map.
     - enabledIf: This mode defines whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.
     */
    public init(with features: [CapableFeature], name: String, enabledIf: HandicapEnabledMode) {
        self.features = features
        self.name = name
        self.enabledIf = enabledIf
    }
}

// MARK: - Equatable
extension Handicap: Equatable {
    public static func == (lhs: Handicap, rhs: Handicap) -> Bool {
        return
            lhs.features == rhs.features &&
            lhs.name == rhs.name &&
            lhs.enabledIf == rhs.enabledIf
    }
}
