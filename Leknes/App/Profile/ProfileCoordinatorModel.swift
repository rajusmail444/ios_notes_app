//
//  ProfileCoordinatorModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 19/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import RxSwift

struct ProfileCoordinatorModel {
    let disposeBag = DisposeBag()
    let navigationStackActions = PublishSubject<NavigationStackAction>()

    init() { }

    func createProfileViewModel() -> ProfileViewModel {
        let profileViewModel = ProfileViewModel()
        profileViewModel.events.subscribe(onNext: { event in
            switch event {
            case .navigateToDetails:
                let detailsViewModel = self.createDetailsViewModel()
                self.navigationStackActions.onNext(.present(viewModel: detailsViewModel,
                                                            animated: true))
            }
        }).disposed(by: disposeBag)
        return profileViewModel
    }

    func createDetailsViewModel() -> DetailsViewModel {
        let detailsViewModel = DetailsViewModel()
        
        return detailsViewModel
    }
}
