//
//  AppFonts.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

public struct AppFonts {
    static public let regular = "CourierNewPSMT"
    static public let bold = "CourierNewPS-BoldMT"
    static public let italic = "CourierNewPS-ItalicMT"

    public static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFonts.bold, size: size)!
    }

    public static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFonts.regular, size: size)!
    }
    
    public static func italic(size: CGFloat) -> UIFont {
        return UIFont(name: AppFonts.italic, size: size)!
    }
}
