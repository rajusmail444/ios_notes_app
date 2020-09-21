//
//  Router.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    func viewController(forViewModel viewModel: Any) -> UIViewController
}

struct Router: RouterProtocol {
    func viewController(forViewModel viewModel: Any) -> UIViewController {
        switch viewModel {

        // MARK: Notes
        case let viewModel as NotesViewModel:
            return UIViewController.make(viewController: NotesViewController.self,
                                         viewModel: viewModel)
            
        // MARK: DETAILS
        case let viewModel as DetailsViewModel:
            return UIViewController.make(viewController: DetailsViewController.self,
                                         viewModel: viewModel)
        default:
            return UIViewController.make(viewController: NotesViewController.self,
                                         viewModel: NotesViewModel())
        }
    }
}


