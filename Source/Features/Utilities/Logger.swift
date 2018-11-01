//
//  Logger.swift
//  Capable
//
//  Created by Christoph Wendt on 31.10.18.
//

import os.log

struct Logger {

    // MARK: Action

    static var onLog: ((String, OSLogType) -> Void)?

    // MARK: Logging API

    static func verbose(_ message: String) {
        onLog?(message, .debug)
    }

    static func info(_ message: String) {
        onLog?(message, .info)
    }

    static func warning(_ message: String) {
        onLog?(message, .default)
    }

    static func error(_ message: String) {
        onLog?(message, .error)
    }

    // MARK: Default logger

    static let defaultLog = OSLog(
        subsystem: "com.chrs1885.capable",
        category: "CapableFramework"
    )

    static var defaultOnLog: (String, OSLogType) -> Void = { message, logType in
        os_log("%{public}@", log: Logger.defaultLog, type: logType, message)
    }
}
