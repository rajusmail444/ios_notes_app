//
//  NewNoteViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum NewNoteViewModelEvent {
}

protocol NewNoteViewModelType {
    var events: PublishSubject<NewNoteViewModelEvent> { get }
}

class NewNoteViewModel: NewNoteViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<NewNoteViewModelEvent>()
    init() {}
}
