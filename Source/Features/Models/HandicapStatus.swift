//
//  HandicapStatus.swift
//  Capable
//
//  Created by Wendt, Christoph on 16.08.18.
//

/**
 Model class that describes the content of a Capable notification (see `Notification.Name.CapableHandicapStatusDidChange`) */
public struct HandicapStatus {

    /// The `Handicap` that has changed.
    public private(set) var handicap: Handicap

    /// The `Handicap`'s status (**enabled** or **disabled**). Note that the status depends on the `Handicap`'s `enabledIf` value (see `HandicapEnabledMode`).
    public private(set) var statusString: String

    /**
     Initializes a new `HandicapStatus` object.

     - Parameters:
     - handicap: The `Handicap` that has changed.
     - statusString: The current value of the `Handicap` (**enabled** or **disabled**).
     */
    init(with handicap: Handicap, statusString: String) {
        self.handicap = handicap
        self.statusString = statusString
    }
}
