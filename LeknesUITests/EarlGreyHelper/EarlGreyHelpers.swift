//
//  EarlGreyHelpers.swift
//  NotesUITests
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation
import WebKit

public struct EarlGreyConstants {
    public static let TimeoutSeconds: CFTimeInterval = 5
}

//swiftlint:disable file_length
public func GREYFail(_ reason: String, error: NSError) {
    GREYFail(reason, error.description)
}

public func grey_configureScreenshotsLocation() {
    let fileURLPath = URL(fileURLWithPath: "\(#file)")
    let fileDirURLPath = fileURLPath.deletingLastPathComponent()
    let screenshotsDirURLPath = URL(fileURLWithPath: "\(fileDirURLPath.path)/../../../fastlane/test_output")

    GREYConfiguration.shared
        .setValue(screenshotsDirURLPath.path, forConfigKey: GREYConfigKey.artifactsDirLocation)
}

public func waitForAppearanceOf(type: AnyClass,
                                accessibilityID: String,
                                timeout: CFTimeInterval = EarlGreyConstants.TimeoutSeconds) {
    let waitForElementToAppear = GREYCondition(name: "wait for element to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                grey_accessibilityID(accessibilityID),
                grey_kindOfClass(type),
                grey_enabled(),
                grey_sufficientlyVisible()
                ]))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForElementToAppear!.wait(withTimeout: timeout) else {
        let errorDescription = "Failed: no appearance of element of type: \"\(type)\""
            + " with accessibilityID: \"\(accessibilityID)\""
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func waitForExistenceOf(accessibilityID: String, timeout: CFTimeInterval = EarlGreyConstants.TimeoutSeconds) {
    let waitForElementToAppear = GREYCondition(name: "wait for element to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                grey_accessibilityID(accessibilityID),
                grey_enabled()
                ]))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForElementToAppear!.wait(withTimeout: timeout) else {
        let errorDescription = "Failed: no appearance of element with accessibilityID: \"\(accessibilityID)\""
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func waitForExistenceOf(text: String, timeout: CFTimeInterval = EarlGreyConstants.TimeoutSeconds) {
    let waitForElementToAppear = GREYCondition(name: "wait for element to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_text(text))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForElementToAppear!.wait(withTimeout: timeout) else {
        let errorDescription = "Failed: no appearance of element with text: \"\(text)\""
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func waitForElementToAppear(accessibilityID: String, timeout: CFTimeInterval = EarlGreyConstants.TimeoutSeconds) {
    let waitForUItoAppear = GREYCondition(name: "wait for Element to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                grey_accessibilityID(accessibilityID),
                grey_sufficientlyVisible()
                ]))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForUItoAppear!.wait(withTimeout: timeout) else {
        let errorDescription = "Failed: element with ID: '\(accessibilityID)' never appeared"
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func waitForUIToAppear(timeout: CFTimeInterval = EarlGreyConstants.TimeoutSeconds) {
    let waitForUItoAppear = GREYCondition(name: "wait for UI to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                // NOTE: accessibilityID is set implicitly on the top level view controller
                grey_kindOfClass(UINavigationBar.self),
                grey_sufficientlyVisible()
                ]))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForUItoAppear!.wait(withTimeout: timeout) else {
        let errorDescription = "Failed: UI never appeared"
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func waitForUINavigationToAppear(title: String, timeout: CFTimeInterval = EarlGreyConstants.TimeoutSeconds) {
    let waitForNavigationBarToAppear = GREYCondition(name: "wait for navigation bar to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                // NOTE: accessibilityID is set implicitly on the top level view controller
                // to match the viewcontroller title.
                grey_accessibilityID(title),
                grey_kindOfClass(UINavigationBar.self),
                grey_minimumVisiblePercent(0.6)
                ]))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForNavigationBarToAppear!.wait(withTimeout: timeout) else {
        let errorDescription = "Failed: UINavigationBar with title: \"\(title)\" never appeared"
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func tapButton(title: String) {
    EarlGrey
        .selectElement(with: grey_allOf([
            grey_buttonTitle(title),
            grey_kindOfClass(UIButton.self),
            grey_sufficientlyVisible()
            ]))
        .perform(grey_tap())
}

public func tapButton(accessibilityID: String) {
    waitForAppearanceOf(type: UIButton.self, accessibilityID: accessibilityID)

    EarlGrey
            .selectElement(with: grey_allOf([
            grey_accessibilityID(accessibilityID),
            grey_kindOfClass(UIButton.self),
            grey_sufficientlyVisible()
            ]))
        .perform(grey_tap())
}

public func tapButton(accessibilityID: String, inside rootAccessibilityID: String) {
    let waitForButtonToAppear = GREYCondition(name: "wait for button to appear") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                grey_kindOfClass(UIButton.self),
                grey_accessibilityID(accessibilityID)
                ]))
            .inRoot(grey_accessibilityID(rootAccessibilityID))
            .assert(grey_sufficientlyVisible(), error: &error)

        return error == nil
    }

    guard waitForButtonToAppear!.wait(withTimeout: 1) else {
        GREYFail("Failed: tapButton(accessibilityID: \"\(accessibilityID)\")")
        return
    }

    EarlGrey
        .selectElement(with: grey_accessibilityID(accessibilityID))
        .inRoot(grey_accessibilityID(rootAccessibilityID))
        .perform(grey_tap())
}

public func tapBackButton(accessibilityLabel: String) {
    EarlGrey
            .selectElement(with: grey_allOf([
            grey_accessibilityLabel(accessibilityLabel),
            grey_accessibilityTrait(UIAccessibilityTraits.button)
            ]))
        .perform(grey_tap())
}

public func tapBarButton(accessibilityID: String) {
    tapElement(accessibilityID: accessibilityID)
}

public func tapElement(accessibilityID: String) {
    waitForExistenceOf(accessibilityID: accessibilityID)

    var error: NSError?

    EarlGrey
            .selectElement(with: grey_accessibilityID(accessibilityID))
        .perform(grey_tap(), error: &error)

    if let error = error {
        GREYFail("Failed: tapElement(accessibilityID: \"\(accessibilityID)\")", error: error)
    }
}

public func tapElement(text: String) {
    var error: NSError?

    EarlGrey
            .selectElement(with: grey_text(text))
        .perform(grey_tap(), error: &error)

    if error != nil {
        GREYFail("Failed: tapElement(text: \"\(text)\")")
    }
}

public func tapVisibleText(text: String, rootAccessibilityID: String) {
 var error: NSError?

    EarlGrey
        .selectElement(with: grey_allOf([
            grey_text(text),
            grey_sufficientlyVisible()]))
        .inRoot(grey_accessibilityID(rootAccessibilityID))
        .assert(grey_notNil(), error: &error)
        .perform(grey_tap())

    if let error = error {
        GREYFail("Failed: tapVisibleText(accessibilityID: \"\(rootAccessibilityID)\")", error: error)
    }
}

public func tapElement(accessibilityLabel: String) {
    var error: NSError?

    EarlGrey
            .selectElement(with: grey_allOf([
            grey_accessibilityLabel(accessibilityLabel),
            grey_sufficientlyVisible()
            ]))
        .perform(grey_tap(), error: &error)

    if let error = error {
        GREYFail("Failed: tapElement(accessibilityLabel: \"\(accessibilityLabel)\")", error: error)
    }
}

public func tapFirstElement(accessibilityLabel: String) {
    var error: NSError?

    EarlGrey
            .selectElement(with: grey_allOf([
            grey_accessibilityLabel(accessibilityLabel),
            grey_firstElement()
            ]))
        .perform(grey_tap(), error: &error)

    if let error = error {
        GREYFail("Failed: tapFirstElement(accessibilityLabel: \"\(accessibilityLabel)\")", error: error)
    }
}

public func grey_firstElement() -> GREYMatcher {
    var firstMatch = true
    let matches: GREYMatchesBlock = { (element: Any?) -> Bool in
        if firstMatch {
            firstMatch = false
            return true
        }
        return false
    }

    let description: GREYDescribeToBlock = { (description: GREYDescription!) -> Void in
        guard let description = description else {
            return
        }
        description.appendText("first match")
    }

    return GREYElementMatcherBlock.init(matchesBlock: matches, descriptionBlock: description)
}

public func assertVisibleLabel(text: String,
                               accessibilityID: String) {
    let waitForLabelToBeVisible = GREYCondition(name: "wait for label to be visible") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                grey_accessibilityID(accessibilityID),
                grey_kindOfClass(UILabel.self),
                grey_text(text),
                grey_sufficientlyVisible()
                ]))
            //.assert(isVisible ? grey_sufficientlyVisible() : grey_notVisible(), error: &error)
            .assert(grey_notNil(), error: &error)
        return error == nil
    }

    guard waitForLabelToBeVisible!.wait(withTimeout: EarlGreyConstants.TimeoutSeconds) else {
        let errorDescription = "Failed: label with text: \"\(text)\", accessibilityID: \"\(accessibilityID)\" never appeared"
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func assertVisibleLabel(text: String, inside rootAccessibilityID: String, isVisible: Bool = true) {

    EarlGrey
            .selectElement(with: grey_allOf([
            grey_kindOfClass(UILabel.self),
            grey_text(text)
            ]))
        .inRoot(grey_accessibilityID(rootAccessibilityID))
        .assert(isVisible ? grey_sufficientlyVisible() : grey_notVisible())

}

public func assertVisible(text: String, inside rootAccessibilityID: String) {
    let waitForTextToBeVisible = GREYCondition(name: "wait for label to be visible") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([grey_text(text),
                                                    grey_sufficientlyVisible()]))
            .inRoot(grey_accessibilityID(rootAccessibilityID))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForTextToBeVisible!.wait(withTimeout: EarlGreyConstants.TimeoutSeconds) else {
        let errorDescription = "Failed: element with text: \"\(text)\", "
            + "inside rootAccessibilityID: \"\(rootAccessibilityID)\" never appeared"
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}

public func assertVisible(text: String, accessibilityID: String) {
    let waitForTextToBeVisible = GREYCondition(name: "wait for label to be visible") {
        var error: NSError?

        EarlGrey
            .selectElement(with: grey_allOf([
                grey_accessibilityID(accessibilityID),
                grey_text(text),
                grey_sufficientlyVisible()]))
            .assert(grey_notNil(), error: &error)

        return error == nil
    }

    guard waitForTextToBeVisible!.wait(withTimeout: EarlGreyConstants.TimeoutSeconds) else {
        let errorDescription = "Failed: element with text: \"\(text)\", "
            + "accessibilityID: \"\(accessibilityID)\" never appeared"
        GREYFail(errorDescription)
        applicationCrash(errorDescription)
    }
}
