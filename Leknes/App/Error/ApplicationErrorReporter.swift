//
//  ApplicationErrorReporter.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 25/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation

public protocol ErrorReporterProtocol {
    func setUserIdentifier(_ identifier: String)
    func recordError(_ error: Error)
    func recordLog(_ log: String)
}

extension ErrorReporterProtocol {
    public func setUserIdentifier(_ identifier: String) {}
}

public class ApplicationErrorReporter {
    public static var errorReporter: ErrorReporterProtocol?
}

public class NonFatalLocalErrorReporterForTesting: ErrorReporterProtocol {

    public init() {}

    public func recordError(_ error: Error) {
        NSLog("%@", error.localizedDescription)
    }

    public func recordLog(_ log: String) {
        NSLog("%@", log)
    }
}

public struct AppError: Error {
    var localizedDescription: String
}

public class UserActivityLog {
    public static var shared = UserActivityLog()
    private init() {}

    // add properties as required
    public var sessionId: String?
}

public class GenericLocalErrorReporter: ErrorReporterProtocol {

    public init() {}

    public func recordError(_ error: Error) {
        fatalError(error.localizedDescription)
    }

    public func recordLog(_ log: String) {
        NSLog("%@", log)
    }
}

public func applicationUserIdentifier(_ identifier: String) {
    guard let errorReporter = ApplicationErrorReporter.errorReporter else {
        fatalError("ApplicationErrorReporter.errorReporter is not configured")
    }
    errorReporter.setUserIdentifier(identifier)
}

public func applicationError(_ description: String = "[undefined error description]",
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
    guard let errorReporter = ApplicationErrorReporter.errorReporter else {
        fatalError("ApplicationErrorReporter.errorReporter is not configured")
    }

    var logMessage = description
    if let bookingSessionId = UserActivityLog.shared.sessionId {
        logMessage = logMessage.appending("for booking sessionId: \(bookingSessionId)")
    }
    let errorDescription = "[\(file) - \(function): \(line)] \(logMessage))"

    let error = NSError(domain: "\(#file) \(#line)",
                        code: 1,
                        userInfo: ["description": errorDescription])
    errorReporter.recordError(error)
}

public func applicationCrash(_ description: String = "[undefined crash description]",
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) -> Never {
    guard let errorReporter = ApplicationErrorReporter.errorReporter else {
        fatalError("ApplicationCrashReporter.errorReporter is not configured")
    }

    var logMessage = description
    if let bookingSessionId = UserActivityLog.shared.sessionId {
        logMessage = logMessage.appending("for booking sessionId: \(bookingSessionId)")
    }
    let errorDescription = "[\(file) - \(function): \(line)] \(logMessage))"

    let error = NSError(domain: "\(#file) \(#line)",
                        code: 1,
                        userInfo: ["description": errorDescription])
    errorReporter.recordError(error)
    fatalError(errorDescription)
}

public func applicationLog(_ separator: String, terminator: String, items: Any...) {
    guard let errorReporter = ApplicationErrorReporter.errorReporter else {
        fatalError("ApplicationErrorReporter.errorReporter is not configured")
    }

    for item in items {
        var outputStream = ""
        print(item, separator: separator, terminator: terminator, to: &outputStream)

        errorReporter.recordLog(outputStream)
    }
}

public func applicationLog(_ description: String) {
    guard let errorReporter = ApplicationErrorReporter.errorReporter else {
        fatalError("ApplicationErrorReporter.errorReporter is not configured")
    }
    errorReporter.recordLog(description)
}

