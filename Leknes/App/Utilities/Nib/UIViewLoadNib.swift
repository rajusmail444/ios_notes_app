//
//  UIViewLoadNib.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

public protocol UIViewLoadNib {
    associatedtype NibViewClass: UIView

    var contentView: UIView! { get set }
}

extension UIViewLoadNib where Self: UIView {
    public func loadNib() {
        Bundle(for: NibViewClass.self).loadNibNamed("\(NibViewClass.self)", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.translatesAutoresizingMaskIntoConstraints = true
    }
}
