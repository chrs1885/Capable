//
//  Handicap.swift
//  Capable
//
//  Created by Christoph Wendt on 15.08.18.
//

/**
 Model class that groups a number of `CapableFeature`s to represent a user's handicap.
 */
public struct Handicap: Equatable {

    /// A list of `CapableFeature`s that are expected to be enabled if a user has this handicap.
    public private(set) var features: [CapableFeature]

    /// The name of the `Handicap` that can be used to uniquely identify the `Handicap`. This name is also used inside the status map.
    public private(set) var name: String

    /// This mode defines whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.
    public private(set) var enabledIf: HandicapEnabledMode
}
