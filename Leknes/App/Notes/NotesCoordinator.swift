//
//  NotesCoordinator.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift

class NotesCoordinator {
    var mainViewController: UINavigationController!
    let notesCoordinatorModel: NotesCoordinatorModel

    private let disposeBag = DisposeBag()
    let router: RouterProtocol = Router()

    init() {
        self.notesCoordinatorModel = NotesCoordinatorModel()

        setupController()
        setupNavigationStackAction()
    }

    private func setupController() {
        let tabBarIcon = UITabBarItem(title: "Notes",
                                      image: UIImage(named: "icTabbarHomeInactive"),
                                      selectedImage: UIImage(named: "icTabbarHomeActive"))
        let viewModel = notesCoordinatorModel.createNotesViewModel()
        let viewController = self.router.viewController(forViewModel: viewModel) as! NotesViewController
        viewController.tabBarItem = tabBarIcon
        mainViewController = UINavigationController(rootViewController: viewController)
        mainViewController.navigationBar.barTintColor = ColorTheme.white
    }

    private func setupNavigationStackAction() {
        notesCoordinatorModel.navigationStackActions
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
                case .pop(let animated):
                    self.getNavigationController()?.popViewController(animated: animated)
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


