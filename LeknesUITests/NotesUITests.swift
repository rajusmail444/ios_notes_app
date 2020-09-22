//
//  NotesUITests.swift
//  NotesUITests
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import XCTest

class NotesUITests: BaseJourneyTest {
    func testExample() {
        EarlGrey.selectElement(with: grey_keyWindow())
            .perform(grey_tap())
    }

    func test_journey() {
        navigateToHome()
        navigateToAddNote()
        navigateToProfile()
    }

    func navigateToHome() {
        assertVisibleLabel(text: "notes_title".localized(),
                           inside: "welcome_home")
    }
    func navigateToAddNote() {
        tapBarButton(accessibilityID: "add_note")
        waitForUIToAppear()
        tapBackButton(accessibilityLabel: "back")
    }
    func navigateToProfile() {
        tapElement(text: "main_tab_Profile".localized())
        assertVisibleLabel(text: "Welcome to Profile".localized(),
                           inside: "welcome_profile")
        waitForUIToAppear()
    }
}
