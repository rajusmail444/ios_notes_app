//
//  NewNoteViewController.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var welcome: Welcome!
    
    typealias ViewModelT = NewNoteViewModelType
    var viewModel: NewNoteViewModelType!

    override func viewDidLoad() {
        self.setupWelcome()
        self.navigationController?.navigationBar.topItem?.accessibilityLabel = "back"
    }
    
    private func setupWelcome() {
        self.welcome.configure(text: "Deatils ...",
                               color: UIColor.orange)
        self.welcome.accessibilityIdentifier = "welcome_details"
    }
}
