//
//  NotesViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum NotesViewModelEvent {
    case navigateToDetails
}

protocol NotesViewModelType {
    var events: PublishSubject<NotesViewModelEvent> { get }
    var detailsButtonTapped: PublishSubject<Void> { get }

}

class NotesViewModel: NotesViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<NotesViewModelEvent>()
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
