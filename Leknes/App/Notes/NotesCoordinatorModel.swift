//
//  NotesCoordinatorModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
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
            case .navigateToNewNote(let note, let noteType):
                let newNoteViewModel = self.createNewNoteViewModel(note, noteType)
                self.navigationStackActions.onNext(.push(viewModel: newNoteViewModel,
                                                         animated: true))
            }
        }).disposed(by: disposeBag)
        return notesViewModel
    }

    func createNewNoteViewModel(_ note: NoteDataModel?,
                                _ noteType: NoteType) -> NewNoteViewModel {
        let newNoteViewModel = NewNoteViewModel(noteInfo: note,
                                                noteType: noteType)
        newNoteViewModel.events.subscribe(onNext: { event in
            switch event {
            case .navigateToNote:
                self.navigationStackActions.onNext(.pop(animated: true))
            }
        }).disposed(by: disposeBag)
        
        return newNoteViewModel
    }
}

