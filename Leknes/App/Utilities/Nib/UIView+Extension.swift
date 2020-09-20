//
//  UIView+Extension.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

extension UIView {

    public func viewFromNib<T>(type: T.Type) -> UIView {
        let nibName = String(describing: T.self)
        guard let classType = type as? AnyClass else {
            fatalError("Class unknown: \(nibName)")
        }

        let nib = UINib(nibName: nibName, bundle: Bundle(for: classType))
        let nibViews = nib.instantiate(withOwner: self, options: nil)

        guard let nibView = nibViews.first as? UIView else {
            fatalError("Unable to create view from nib \(nibName)")
        }

        nibView.frame = self.bounds
        nibView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        return nibView
    }

    public func viewFromNib(nibName: String) -> UIView {
        guard let className = NSClassFromString(nibName) else {
            fatalError("Class unknown: \(nibName)")
        }

        let nib = UINib(nibName: nibName, bundle: Bundle(for: className))
        let nibViews = nib.instantiate(withOwner: self, options: nil)

        guard let nibView = nibViews.first as? UIView else {
            fatalError("Unable to create view from nib \(nibName)")
        }

        nibView.frame = self.bounds
        nibView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        return nibView
    }
}

