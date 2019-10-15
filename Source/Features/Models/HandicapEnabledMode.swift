//
//  HandicapEnabledMode.swift
//  Capable
//
//  Created by Christoph Wendt on 15.08.18.
//

/// This enum defines several modes which describe whether all features need to be enabled to set the `Handicap`'s status to enabled or only one of them.
public enum HandicapEnabledMode: String {
    /// The `Handicap`'s status is enabled if one of its features is currently set to **enabled**.
    case oneFeatureEnabled

    /// The `Handicap`'s status is enabled if all its features are currently set to **enabled**.
    case allFeaturesEnabled
}
