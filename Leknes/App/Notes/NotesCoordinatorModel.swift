//
//  NotesCoordinatorModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 18/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import RxSwift

struct NotesCoordinatorModel {
    let disposeBag = DisposeBag()
    let navigationStackActions = PublishSubject<NavigationStackAction>()

    init() { }

    func createNotesViewModel() -> NotesViewModel {
        let notesViewModel = NotesViewModel()
        notesViewModel.events.subscribe(onNext: { event in
            switch event {
            case .navigateToNewNote:
                let newNoteViewModel = self.createNewNoteViewModel()
                self.navigationStackActions.onNext(.push(viewModel: newNoteViewModel,
                                                         animated: true))
            }
        }).disposed(by: disposeBag)
        return notesViewModel
    }

    func createNewNoteViewModel() -> NewNoteViewModel {
        let newNoteViewModel = NewNoteViewModel()
        
        return newNoteViewModel
    }
}

