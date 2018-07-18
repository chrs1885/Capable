//
//  FeatureStatus.swift
//  Capable
//
//  Created by Christoph Wendt on 28.03.18.
//

/**
 Model class that describes the content of a Capable notification

 @see Notification+Name.swift
 */
public struct FeatureStatus {

    /// The feature type.
    public private(set) var feature: CapableFeature

    /// The feature's status: While most features can only have a status set to **enabled** or **disabled**, the '.largerText` feature offers the font scale set by the user.
    public private(set) var statusString: String

    /**
     Initializes a new `FeatureStatus` object.

     - Parameters:
        - feature: The corresponding feature type.
        - statusString: The current value of the feature. While most features can only have a status set to **enabled** or **disabled**, the `.largerText` feature offers the font scale set by the user.
     */
    init(with feature: CapableFeature, statusString: String) {
        self.feature = feature
        self.statusString = statusString
    }
}
