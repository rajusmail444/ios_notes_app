//
//  String+Extension.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation

extension String {
    public func localized(_ bundle: Bundle = Bundle.main, tableName: String? = nil) -> String {
        let locale = ""
        
        guard let path = bundle.path(forResource: locale, ofType: "lproj"),
            let localized = Bundle(path: path) else {
                return fallBack(bundle: bundle)
        }
        
        let localizedString = NSLocalizedString(self, tableName: tableName, bundle: localized, value: "", comment: "")
        let originalString = self
        
        if localizedString == originalString {
            return fallBack(bundle: bundle)
        }
        
        return localizedString
    }
    
    private func fallBack(bundle: Bundle) -> String {
        guard let path = bundle.path(forResource: "en", ofType: "lproj"),
            let englishBundle = Bundle(path: path) else {
                return ""
        }
        let localizedString = NSLocalizedString(self, tableName: nil, bundle: englishBundle, value: "", comment: "")
        return localizedString
    }
}
