//
//  HomeViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum HomeViewModelEvent {
    case navigateToDetails
}

protocol HomeViewModelType {
    var events: PublishSubject<HomeViewModelEvent> { get }
    var detailsButtonTapped: PublishSubject<Void> { get }

}

class HomeViewModel: HomeViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<HomeViewModelEvent>()
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
