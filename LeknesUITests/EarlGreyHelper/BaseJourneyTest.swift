//
//  BaseJourneyTest.swift
//  LeknesUITests
//
//  Created by Rajesh Billakanti on 25/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation

protocol BaseJourneyTestLaunchArguments {
    func launchArguments() -> [String]
}

class BaseJourneyTest: XCTestCase, BaseJourneyTestLaunchArguments {
    var window: XCUIElement!
    var app: XCUIApplication!

    func launchArguments() -> [String] {
        return ["UI-Testing"]
    }

    override func setUp() {
        super.setUp()
        ApplicationErrorReporter.errorReporter = GenericLocalErrorReporter()
        app = XCUIApplication()
        app.launchArguments = launchArguments()
        app.launch()

        GREYConfiguration.shared.setValue([".*.somehost\\.com"], forConfigKey: GREYConfigKey.urlBlacklistRegex)
        GREYHostApplicationDistantObject.sharedInstance.enableFastAnimation()
        window = app.windows.allElementsBoundByIndex.first { element in
            element.frame.width > 10
        }
        grey_configureScreenshotsLocation()
    }

    func setupWithArgs(launchArguments: [String]) {
        super.setUp()
        ApplicationErrorReporter.errorReporter = GenericLocalErrorReporter()
        let app = XCUIApplication()
        app.launchArguments = launchArguments + ["UI-Testing"]
        app.launch()

        GREYConfiguration.shared.setValue([".*.somehost\\.com"], forConfigKey: GREYConfigKey.urlBlacklistRegex)
        GREYHostApplicationDistantObject.sharedInstance.enableFastAnimation()
        window = app.windows.allElementsBoundByIndex.first { element in
            element.frame.width > 10
        }
        grey_configureScreenshotsLocation()
    }

    override func tearDown() {
        super.tearDown()
    }

    func navigateToMainView() {
        checkAndAcceptPushNotificationAlert()
        submitPreferences()
        acceptTermsAndConditionsView()
    }

    func checkAndAcceptPushNotificationAlert() {
        if self.grey_wait(forAlertVisibility: true, withTimeout: 2) {
            if self.grey_systemAlertType() == .notifications {
                self.grey_acceptSystemDialogWithError(nil)
                self.grey_wait(forAlertVisibility: false, withTimeout: 1.0)
            }
        }
    }

    func submitPreferences() {
        waitForElementToAppear(accessibilityID: "LocationLanguageSettingsView", timeout: 30)
        tapButton(title: "submit")
    }

    func acceptTermsAndConditionsView() {
        waitForElementToAppear(accessibilityID: "TermsAndConditionsView", timeout: 30)
        tapButton(title: "accept")
    }
}

extension String {
    func localized(_ bundle: Bundle = Bundle(for: BaseJourneyTest.self), tableName: String? = nil) -> String {
        let locale = ""

        guard let path = bundle.path(forResource: locale, ofType: "lproj"),
            let localized = Bundle(path: path) else {
                return fallBack(bundle: bundle)
        }

        let localizedString = NSLocalizedString(self, tableName: tableName, bundle: localized, value: "", comment: "")
        let originalString = self

        if localizedString == originalString {
            return fallBack(bundle: bundle)
        }

        return localizedString
    }

    private func fallBack(bundle: Bundle) -> String {
        guard let path = bundle.path(forResource: "en", ofType: "lproj"),
            let englishBundle = Bundle(path: path) else {
                applicationError("Failed to find localized file for locale: en")
                return ""
        }
        let localizedString = NSLocalizedString(self, tableName: nil, bundle: englishBundle, value: "", comment: "")
        return localizedString
    }
}
