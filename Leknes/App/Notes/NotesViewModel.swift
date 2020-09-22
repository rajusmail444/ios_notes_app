//
//  NotesViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum NotesViewModelEvent {
    case navigateToNewNote(NoteDataModel?, NoteType)
}

extension NotesViewModelEvent: Equatable {
    static func == (lhs: NotesViewModelEvent,
                    rhs: NotesViewModelEvent) -> Bool {
        switch (lhs, rhs) {
        case (.navigateToNewNote, .navigateToNewNote):
            return true
        }
    }


}

protocol NotesViewModelType {
    var events: PublishSubject<NotesViewModelEvent> { get }
    var addButtonTapped: PublishSubject<Void> { get }
    var editButtonTapped: PublishSubject<NoteDataModel?> { get }
    var title: String { get }
    var noteStorage: NoteStorage { get }
}

class NotesViewModel: NotesViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<NotesViewModelEvent>()
    var addButtonTapped = PublishSubject<Void>()
    var editButtonTapped = PublishSubject<NoteDataModel?>()
    var title: String
    var noteStorage: NoteStorage
    init(noteStorage: NoteStorage = NoteStorage.storage) {
        self.title = "notes_title".localized()
        self.noteStorage = noteStorage
        setupNavigateToNewNote()
        setupNavigateToEditNote()
    }
    
    private func setupNavigateToNewNote() {
        self.addButtonTapped.asObservable()
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                let emptyObject = NoteDataModel(noteTitle: "",
                                                noteText: "",
                                                noteTimeStamp: Date().toSeconds())
                self.events.onNext(.navigateToNewNote(emptyObject, .AddNote))
            }).disposed(by: disposeBag)
    }

    private func setupNavigateToEditNote() {
        self.editButtonTapped.asObservable()
            .subscribe(onNext: {[weak self] noteObject in
                guard let self = self else { return }
                self.events.onNext(.navigateToNewNote(noteObject, .EditNote))
            }).disposed(by: disposeBag)
    }
}
