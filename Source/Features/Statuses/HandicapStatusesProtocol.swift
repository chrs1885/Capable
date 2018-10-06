//
//  HandicapStatusesProtocol.swift
//  Capable
//
//  Created by Christoph Wendt on 12.09.18.
//

protocol HandicapStatusesProtocol: StatusesProtocol {
    func isHandicapEnabled(handicapName: String) -> Bool
}
