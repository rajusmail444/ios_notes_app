//
//  NewNoteViewModel.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import RxSwift

enum NewNoteViewModelEvent {
    case navigateToNote
}

protocol NewNoteViewModelType {
    var events: PublishSubject<NewNoteViewModelEvent> { get }
    var noteInfo: NoteDataModel? { get }
    var callToActionTitle: String { get }
    var formTitle: String { get }
    var noteType: NoteType { get }
    var isNoteObjectEmpty: Bool { get }
    var callToActionTapped: PublishSubject<NoteDataModel?> { get }
}

class NewNoteViewModel: NewNoteViewModelType {
    let disposeBag = DisposeBag()
    var events = PublishSubject<NewNoteViewModelEvent>()
    var noteInfo: NoteDataModel?
    var noteType: NoteType
    var noteStorage: NoteStorage
    var callToActionTapped = PublishSubject<NoteDataModel?>()
    var callToActionTitle: String = ""
    var formTitle: String = ""

    public var isNoteObjectEmpty: Bool {
        return nil == noteInfo || noteInfo?.noteTitle == nil || noteInfo?.noteTitle == ""
    }

    init(noteInfo: NoteDataModel?,
         noteType: NoteType,
         noteStorage: NoteStorage = NoteStorage.storage) {
        self.noteInfo = noteInfo
        self.noteType = noteType
        self.noteStorage = noteStorage
        self.setupForm()
        self.setupNoteStorage()
    }

    private func setupForm() {
        switch self.noteType {
        case .AddNote:
            self.formTitle = "new_note".localized()
            self.callToActionTitle = "add_note".localized()
        case .EditNote:
            self.formTitle = "edit_note".localized()
            self.callToActionTitle = "save".localized()
        }
    }

    private func setupNoteStorage() {
        self.callToActionTapped.asObservable()
            .subscribe(onNext: {[weak self] noteObject in
                guard let self = self else { return }
                switch self.noteType {
                case .AddNote:
                    self.noteStorage.addNote(noteToBeAdded: noteObject!)
                case .EditNote:
                    self.noteStorage.changeNote(noteToBeChanged: noteObject!)
                }
                self.events.onNext(.navigateToNote)
            }).disposed(by: disposeBag)
    }
}
