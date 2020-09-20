//
//  UIViewController+Extension.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

extension UIViewController {
    public static func make<T: ViewControllerProtocol>(viewController: T.Type,
                                                       viewModel: T.ViewModelT) -> T {
        var viewController = make(viewController: viewController)
        viewController.viewModel = viewModel
        return viewController
    }

    public static func make<T>(viewController: T.Type) -> T {
        let viewControllerName = String(describing: viewController)

        let storyboard = UIStoryboard(name: viewControllerName, bundle: Bundle(for: viewController as! AnyClass))

        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? T else {
            fatalError("Unable to create ViewController: \(viewControllerName) from storyboard: \(storyboard)")
        }
        return viewController
    }
}

extension UINavigationController {
    public static func makeForTabBar<T: UIViewController>(viewController: T.Type,
                                                          title: String,
                                                          defaultTabBarImage: String,
                                                          selectedTabBarImage: String) -> UINavigationController {
        let tabBarIcon = UITabBarItem(title: title,
                                      image: UIImage(named: defaultTabBarImage),
                                      selectedImage: UIImage(named: selectedTabBarImage))
        let viewController = UIViewController.make(viewController: viewController)
        viewController.tabBarItem = tabBarIcon
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}


