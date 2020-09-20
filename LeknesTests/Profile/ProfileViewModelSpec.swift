//
//  ProfileViewModelSpec.swift
//  LeknesTests
//
//  Created by Rajesh Billakanti on 20/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
import RxSwift
import RxTest

@testable import Leknes

class ProfileViewModelSpec: QuickSpec {
    override func spec() {
        var subject: ProfileViewModel!
        var disposeBag: DisposeBag!
        describe("ProfileViewModel") {
            beforeEach {
                disposeBag = DisposeBag()
            }
            context("when to display Lunch menu") {
                var actualEvent: ProfileViewModelEvent?
                var expectedEvent: ProfileViewModelEvent?
                beforeEach {
                    subject = ProfileViewModel()
                    actualEvent = ObservableHelpers
                        .latestValueFrom(observable: subject.events,
                                         disposeBag: disposeBag) {
                                            subject.detailsButtonTapped.onNext(())
                    }
                    expectedEvent = .navigateToDetails
                }
                it("should display page title as Lunch") {
                    expect(expectedEvent).to(equal(actualEvent))
                }
            }
        }
    }
}
