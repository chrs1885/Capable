//
//  FontMetricsProviderMock.swift
//  CapableTests
//
//  Created by Wendt, Christoph on 03.08.18.
//

#if os(iOS) || os(tvOS)

    @testable import Capable

    class FontMetricsProviderMock: FontMetricsProviderProtocol {
        let fontMetrics: FontMetricsProtocol

        init(fontMetrics: FontMetricsProtocol) {
            self.fontMetrics = fontMetrics
        }
    }

#endif
