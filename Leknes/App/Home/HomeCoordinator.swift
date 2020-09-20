//
//  HomeCoordinator.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift

class HomeCoordinator {
    var mainViewController: UINavigationController!
    let homeCoordinatorModel: HomeCoordinatorModel

    private let disposeBag = DisposeBag()
    let router: RouterProtocol = Router()

    init() {
        self.homeCoordinatorModel = HomeCoordinatorModel()

        setupController()
        setupNavigationStackAction()
    }

    private func setupController() {
        let tabBarIcon = UITabBarItem(title: "Home",
                                      image: UIImage(named: "icTabbarHomeInactive"),
                                      selectedImage: UIImage(named: "icTabbarHomeActive"))
        let viewModel = homeCoordinatorModel.createHomeViewModel()
        let viewController = self.router.viewController(forViewModel: viewModel) as! HomeViewController
        viewController.tabBarItem = tabBarIcon
        mainViewController = UINavigationController(rootViewController: viewController)
        mainViewController.navigationBar.barTintColor = ColorTheme.white
    }

    private func setupNavigationStackAction() {
        homeCoordinatorModel.navigationStackActions
            .subscribe(onNext: { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .push(viewModel: viewModel, animated: animated):
                    self.getNavigationController()
                        .pushViewController((self.router
                            .viewController(forViewModel: viewModel)),
                                            animated: animated)
                case .present(let viewModel, let animated):
                    self.getNavigationController()
                        .present(UINavigationController(rootViewController:
                            (self.router.viewController(forViewModel: viewModel))),
                                 animated: animated, completion: nil)
                case .dismiss(let animated):
                    self.getNavigationController().dismiss(animated: animated, completion: nil)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    private func getNavigationController() -> UINavigationController! {
        return self.mainViewController
    }
}


