//
//  NotesViewModelSpec.swift
//  LeknesTests
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
import RxSwift
import RxTest

@testable import Notes

class NotesViewModelSpec: QuickSpec {
    override func spec() {
        var subject: NotesViewModel!
        var disposeBag: DisposeBag!
        describe("NotesViewModel") {
            beforeEach {
                disposeBag = DisposeBag()
            }
            context("when to display Lunch menu") {
                var actualEvent: NotesViewModelEvent?
                var expectedEvent: NotesViewModelEvent?
                beforeEach {
                    subject = NotesViewModel()
                    actualEvent = ObservableHelpers
                        .latestValueFrom(observable: subject.events,
                                         disposeBag: disposeBag) {
                                            subject.addButtonTapped.onNext(())
                    }
                    expectedEvent = .navigateToNewNote(NoteDataModel(noteTitle: "",
                                                                     noteText: "",
                                                                     noteTimeStamp: Date().toSeconds()),
                                                       .AddNote)
                }
                it("should display page title as Lunch") {
                    expect(expectedEvent).to(equal(actualEvent))
                }
            }
        }
    }
}
