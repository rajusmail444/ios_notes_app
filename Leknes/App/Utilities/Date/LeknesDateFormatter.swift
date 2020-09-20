//
//  LeknesDateFormatter.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 24/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation

/// Wrapper class for DateFormatter with a default initializer to override device calendar
public final class LeknesDateFormatter: DateFormatter {
    public init(_ calendarIdentifier: Calendar.Identifier = .gregorian) {
        super.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.calendar = Calendar(identifier: calendarIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
