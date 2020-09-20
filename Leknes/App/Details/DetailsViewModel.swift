//
//  DetailsViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum DetailsViewModelEvent {
}

protocol DetailsViewModelType {
    var events: PublishSubject<DetailsViewModelEvent> { get }
}

class DetailsViewModel: DetailsViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<DetailsViewModelEvent>()
    init() {}
}
