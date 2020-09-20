//
//  MainViewCoordinator.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift

class MainViewCoordinator {
    var tabBarController: UITabBarController!
    var homeCoordinator: HomeCoordinator!
    var profileCoordinator: ProfileCoordinator!
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.homeCoordinator = HomeCoordinator()
        self.profileCoordinator = ProfileCoordinator()
        tabBarController.viewControllers = [
            homeCoordinator.mainViewController,
            profileCoordinator.mainViewController
        ]
    }

    func present(viewController: UIViewController) {
        self.tabBarController.present(viewController, animated: true, completion: nil)
    }
}

