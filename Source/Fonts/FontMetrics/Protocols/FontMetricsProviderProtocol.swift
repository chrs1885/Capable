//
//  FontMetricsProviderProtocol.swift
//  Capable
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

protocol FontMetricsProviderProtocol {
    var fontMetrics: FontMetricsProtocol { get }
}

#endif
