//
//  MainViewController.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 14/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UITabBarController {
    var mainViewCoordinator: MainViewCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("[MainViewController] Failed to get appDelegate from UIApplication.shared.delegate")
        }

        guard let tabBarController = delegate.window?.rootViewController as? UITabBarController else {
            fatalError("[MainViewController] Failed to get tabBarController from rootViewController")
        }

        mainViewCoordinator = MainViewCoordinator(tabBarController: tabBarController)
    }
}

