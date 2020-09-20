//
//  ProfileCoordinator.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 19/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift

class ProfileCoordinator {
    var mainViewController: UINavigationController!
    let profileCoordinatorModel: ProfileCoordinatorModel

    private let disposeBag = DisposeBag()
    let router: RouterProtocol = Router()

    init() {
        self.profileCoordinatorModel = ProfileCoordinatorModel()

        setupController()
        setupNavigationStackAction()
    }

    private func setupController() {
        let tabBarIcon = UITabBarItem(title: "Profile",
                                      image: UIImage(named: "icNavbarKfloginLoggedout"),
                                      selectedImage: UIImage(named: "icNavbarKfloginLoggedin`"))
        let viewModel = profileCoordinatorModel.createProfileViewModel()
        let viewController = self.router.viewController(forViewModel: viewModel) as! ProfileViewController
        viewController.tabBarItem = tabBarIcon
        mainViewController = UINavigationController(rootViewController: viewController)
        mainViewController.navigationBar.barTintColor = ColorTheme.white
    }

    private func setupNavigationStackAction() {
        profileCoordinatorModel.navigationStackActions
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



