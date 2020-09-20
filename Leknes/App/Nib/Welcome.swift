//
//  Welcome.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

class Welcome: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
        self.setupUI()
    }

    open func xibSetup() {
        if self.contentView == nil {
            let contentView = self.viewFromNib(type: Welcome.self)
            self.addSubview(contentView)
            self.contentView = contentView
        }
    }

    func configure(text: String, color: UIColor) {
        self.welcomeLabel.text = text
        self.welcomeLabel.backgroundColor = color
    }

    private func setupUI() {
        self.welcomeLabel.font = AppFonts.boldFont(size: 24)
        self.welcomeLabel.textColor = ColorTheme.white
        self.welcomeLabel.textAlignment = .center
        self.backgroundColor = ColorTheme.white
    }
}
