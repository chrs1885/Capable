//
//  LoggerTests.swift
//  Capable
//
//  Created by Christoph Wendt on 09.11.18.
//

@testable import Capable
import Nimble
import os.log
import Quick

class LoggerTests: QuickSpec {
    override func spec() {
        describe("The Logger class") {
            var testLoggedMessagesTypes: [OSLogType]?
            var testOnLog: ((String, OSLogType) -> Void)?

            beforeEach {
                testLoggedMessagesTypes = []
                testOnLog = { _, logType in
                    testLoggedMessagesTypes?.append(logType)
                }
                Logger.onLog = testOnLog!
            }

            context("when logType is set to debug") {
                beforeEach {
                    Logger.minLogType = .debug
                    logMessagesForAllTypes()
                }

                it("logs messages for all log types") {
                    expect(testLoggedMessagesTypes!).to(haveCount(5))
                    expect(testLoggedMessagesTypes!).to(contain(.debug))
                    expect(testLoggedMessagesTypes!).to(contain(.info))
                    expect(testLoggedMessagesTypes!).to(contain(.default))
                    expect(testLoggedMessagesTypes!).to(contain(.error))
                    expect(testLoggedMessagesTypes!).to(contain(.fault))
                }
            }

            context("when logType is set to info") {
                beforeEach {
                    Logger.minLogType = .info
                    logMessagesForAllTypes()
                }

                it("logs messages for all log types") {
                    expect(testLoggedMessagesTypes!).to(haveCount(4))
                    expect(testLoggedMessagesTypes!).to(contain(.info))
                    expect(testLoggedMessagesTypes!).to(contain(.default))
                    expect(testLoggedMessagesTypes!).to(contain(.error))
                    expect(testLoggedMessagesTypes!).to(contain(.fault))
                }
            }

            context("when logType is set to default") {
                beforeEach {
                    Logger.minLogType = .default
                    logMessagesForAllTypes()
                }

                it("logs messages for all log types") {
                    expect(testLoggedMessagesTypes!).to(haveCount(3))
                    expect(testLoggedMessagesTypes!).to(contain(.default))
                    expect(testLoggedMessagesTypes!).to(contain(.error))
                    expect(testLoggedMessagesTypes!).to(contain(.fault))
                }
            }

            context("when logType is set to error") {
                beforeEach {
                    Logger.minLogType = .error
                    logMessagesForAllTypes()
                }

                it("logs messages for all log types") {
                    expect(testLoggedMessagesTypes!).to(haveCount(2))
                    expect(testLoggedMessagesTypes!).to(contain(.error))
                    expect(testLoggedMessagesTypes!).to(contain(.fault))
                }
            }

            context("when logType is set to fault") {
                beforeEach {
                    Logger.minLogType = .fault
                    logMessagesForAllTypes()
                }

                it("logs messages for all log types") {
                    expect(testLoggedMessagesTypes!).to(haveCount(1))
                    expect(testLoggedMessagesTypes!).to(contain(.fault))
                }
            }
        }

        func logMessagesForAllTypes() {
            Logger.verbose("test")
            Logger.info("test")
            Logger.warning("test")
            Logger.error("test")
            Logger.systemError("test")
        }
    }
}
