//
//  LeknesUITests.swift
//  LeknesUITests
//
//  Created by Rajesh Billakanti on 24/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import XCTest

class LeknesUITests: BaseJourneyTest {
    func testExample() {
        EarlGrey.selectElement(with: grey_keyWindow())
            .perform(grey_tap())
    }

    func test_journey() {
        navigateToHome()
        navigateToDetails()
        navigateToProfile()
    }

    func navigateToHome() {
        tapElement(text: "main_tab_Home".localized())
        assertVisibleLabel(text: "Welcome_to_Leknes".localized(),
                           inside: "welcome_home")
        waitForUIToAppear()
    }
    func navigateToDetails() {
        tapElement(text: "Details")
        waitForUIToAppear()
        tapBackButton(accessibilityLabel: "back")
    }
    func navigateToProfile() {
        tapElement(text: "main_tab_Profile".localized())
        assertVisibleLabel(text: "Welcome to Profile".localized(),
                           inside: "welcome_profile")
        waitForUIToAppear()
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
