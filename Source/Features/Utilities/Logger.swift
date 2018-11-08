//
//  Logger.swift
//  Capable
//
//  Created by Christoph Wendt on 31.10.18.
//

import os.log

struct Logger {

    // MARK: - Action

    static var onLog: ((String, OSLogType) -> Void) = defaultOnLog

    // MARK: - Logging API

    static func verbose(_ message: String) {
        if logType >= .debug {
            onLog(message, .debug)
        }
    }

    static func info(_ message: String) {
        if logType >= .info {
            onLog(message, .info)
        }
    }

    static func warning(_ message: String) {
        if logType >= .default {
            onLog(message, .default)
        }
    }

    static func error(_ message: String) {
        if logType >= .error {
            onLog(message, .error)
        }
    }

    static var logType: OSLogType = .default

    // MARK: - Default logger

    static let defaultLog = OSLog(
        subsystem: "com.chrs1885.capable",
        category: "general"
    )

    static var defaultOnLog: (String, OSLogType) -> Void = { message, logType in
        os_log("%{public}@", log: Logger.defaultLog, type: logType, message)
    }
}
