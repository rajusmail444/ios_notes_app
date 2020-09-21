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
    var notesCoordinator: NotesCoordinator!
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.notesCoordinator = NotesCoordinator()
        tabBarController.viewControllers = [
            notesCoordinator.mainViewController
        ]
    }

    func present(viewController: UIViewController) {
        self.tabBarController.present(viewController, animated: true, completion: nil)
    }
}

