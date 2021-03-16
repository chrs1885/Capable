//
//  CapableTests.swift
//  CapableTests
//
//  Created by Christoph Wendt on 23.03.18.
//

#if os(iOS) || os(tvOS) || os(OSX)

    @testable import Capable
    import Nimble
    import os.log
    import Quick

    class CapableTests: QuickSpec {
        override func spec() {
            describe("The Capable class") {
                var featureStatusesProviderMock: FeatureStatusesProviderMock?

                beforeEach {
                    featureStatusesProviderMock = FeatureStatusesProviderMock()
                }

                context("after initialization with features") {
                    context("when providing specific features") {
                        var sut: Capable?
                        var testedFeatures: [CapableFeature]?

                        beforeEach {
                            testedFeatures = [.reduceMotion, .voiceOver]
                            sut = Capable(withFeatures: testedFeatures!)
                        }

                        it("creates a Capable instance") {
                            expect(sut!).to(beAnInstanceOf(Capable.self))
                        }

                        it("initializes its feature statuses provider correctly") {
                            expect(sut!.featureStatusesProvider).to(beAnInstanceOf(FeatureStatusesProvider.self))
                        }

                        it("initializes its statuses module correctly") {
                            expect(sut!.statusesModule).to(beAnInstanceOf(FeatureStatuses.self))
                            // swiftlint:disable force_cast
                            let featureStatuses = sut!.statusesModule as! FeatureStatuses
                            // swiftlint:enable force_cast
                            expect(featureStatuses.features).to(equal(sut!.features))
                            expect(featureStatuses.featureStatusesProvider).to(be(sut!.featureStatusesProvider))
                        }

                        it("initializes its notifications module correctly") {
                            expect(sut!.notificationsModule).to(beAnInstanceOf(FeatureNotifications.self))
                            // swiftlint:disable force_cast
                            let featureNotifications = sut!.notificationsModule as! FeatureNotifications
                            // swiftlint:enable force_cast

                            expect(featureNotifications.featureStatusesProvider).to(be(sut!.featureStatusesProvider))
                            expect(featureNotifications.targetNotificationCenter).to(equal(NotificationCenter.default))

                            #if os(OSX)
                                expect(featureNotifications.systemNotificationCenter).to(equal(NSWorkspace.shared.notificationCenter))
                            #else
                                expect(featureNotifications.systemNotificationCenter).to(equal(NotificationCenter.default))
                            #endif
                        }

                        it("sets the features property correctly") {
                            expect(sut!.features).to(equal(testedFeatures))
                        }
                    }

                    context("when providing no parameters") {
                        var sut: Capable?

                        beforeEach {
                            sut = Capable()
                        }

                        it("registeres all features") {
                            expect(sut!.features).to(equal(CapableFeature.allCases))
                        }
                    }

                    context("after initialization") {
                        var sut: Capable?
                        var testStatuses: FeatureStatusesMock?

                        beforeEach {
                            testStatuses = FeatureStatusesMock()
                            sut = Capable(withFeatures: [], featureStatusesProvider: featureStatusesProviderMock!, statusesModule: testStatuses!, notificationModule: FeatureNotifications(featureStatusesProvider: featureStatusesProviderMock!))
                        }

                        context("when calling statusMap") {
                            beforeEach {
                                _ = sut!.statusMap
                            }

                            it("requests the status map from the statuses module") {
                                expect(testStatuses!.didCallStatusMap).to(beTrue())
                            }
                        }

                        context("when calling isFeatureEnabled") {
                            beforeEach {
                                _ = sut!.isFeatureEnabled(feature: .voiceOver)
                            }

                            it("requests the status map from the statuses module") {
                                expect(featureStatusesProviderMock!.didCallIsFeatureEnabled).to(beTrue())
                            }
                        }
                    }
                }
            }
        }
    }

#endif
