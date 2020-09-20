//
//  HomeCoordinatorModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import RxSwift

struct HomeCoordinatorModel {
    let disposeBag = DisposeBag()
    let navigationStackActions = PublishSubject<NavigationStackAction>()

    init() { }

    func createHomeViewModel() -> HomeViewModel {
        let homeViewModel = HomeViewModel()
        homeViewModel.events.subscribe(onNext: { event in
            switch event {
            case .navigateToDetails:
                let detailsViewModel = self.createDetailsViewModel()
                self.navigationStackActions.onNext(.push(viewModel: detailsViewModel,
                                                         animated: true))
            }
        }).disposed(by: disposeBag)
        return homeViewModel
    }

    func createDetailsViewModel() -> DetailsViewModel {
        let detailsViewModel = DetailsViewModel()
        
        return detailsViewModel
    }
}

