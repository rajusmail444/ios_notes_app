//
//  ProfileViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 19/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum ProfileViewModelEvent {
    case navigateToDetails
}

protocol ProfileViewModelType {
    var events: PublishSubject<ProfileViewModelEvent> { get }
    var detailsButtonTapped: PublishSubject<Void> { get }

}

class ProfileViewModel: ProfileViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<ProfileViewModelEvent>()
    var detailsButtonTapped = PublishSubject<Void>()
    init() {
        setupNavigateToDetails()
    }
    
    private func setupNavigateToDetails() {
        self.detailsButtonTapped.asObservable()
            .subscribe(onNext: {
                self.events.onNext(.navigateToDetails)
            }).disposed(by: disposeBag)
    }
}
