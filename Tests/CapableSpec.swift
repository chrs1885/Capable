//
//  CapableTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.03.18.
//

import Quick
import Nimble
@testable import Capable

class CapableSpec: QuickSpec {
    override func spec() {
        describe("the Capable class") {
            context("after default initialization") {
                var sut: Capable?
                
                beforeEach() {
                    sut = Capable()
                }
                
                it("returns a status map with all features") {
                    let statusMap = sut!.statusMap
                    expect(statusMap.count).to(equal(CapableFeature.allValues().count))
                    expect(Array(statusMap.keys)).to(contain(CapableFeature.allValues()))
                }
            }
            
            context("after initialization with specific features") {
                var sut: Capable?
                let testedFeatures: [CapableFeature] = [.AssistiveTouch, .BoldText]
                
                beforeEach() {
                    sut = Capable(with: testedFeatures)
                }
                
                it("returns a status map with features that were registered") {
                    let statusMap = sut!.statusMap
                    expect(statusMap.count).to(equal(testedFeatures.count))
                    expect(Array(statusMap.keys)).to(contain(testedFeatures))
                }
            }
        }
    }
}
