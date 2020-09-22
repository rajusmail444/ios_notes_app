//
//  Date+Extension.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 22/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
extension Date {
    func toSeconds() -> Int64! {
        return Int64((self.timeIntervalSince1970).rounded())
    }

    init(seconds:Int64!) {
        self = Date(timeIntervalSince1970: TimeInterval(Double.init(seconds)))
    }
}
