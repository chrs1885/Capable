//
//  FeatureStatus.swift
//  Capable
//
//  Created by Christoph Wendt on 28.03.18.
//

public struct FeatureStatus {
    public private(set) var feature: CapableFeature
    public private(set) var statusString: String
    
    init(with feature: CapableFeature, statusString: String) {
        self.feature = feature
        self.statusString = statusString
    }
}
