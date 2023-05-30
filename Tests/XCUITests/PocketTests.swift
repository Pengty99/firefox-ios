// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import XCTest

class PocketTest: BaseTestCase {
    func testPocketEnabledByDefault() {
        navigator.goto(NewTabScreen)
        waitForExistence(app.staticTexts[AccessibilityIdentifiers.FirefoxHomepage.SectionTitles.pocket])
        XCTAssertEqual(app.staticTexts[AccessibilityIdentifiers.FirefoxHomepage.SectionTitles.pocket].label, "Thought-Provoking Stories")

        // There should be two stories on iPhone and three on iPad
        let numPocketStories = app.collectionViews.containing(.cell, identifier: AccessibilityIdentifiers.FirefoxHomepage.TopSites.itemCell).children(matching: .cell).count-1
         if iPad() {
            XCTAssertEqual(numPocketStories, 15)
        } else {
            XCTAssertEqual(numPocketStories, 8)
        }
        // Disable Pocket
        navigator.performAction(Action.TogglePocketInNewTab)

        navigator.goto(NewTabScreen)
        waitForNoExistence(app.staticTexts[AccessibilityIdentifiers.FirefoxHomepage.SectionTitles.pocket])
        // Enable it again
        navigator.performAction(Action.TogglePocketInNewTab)
        navigator.goto(NewTabScreen)
        waitForExistence(app.staticTexts[AccessibilityIdentifiers.FirefoxHomepage.SectionTitles.pocket])

        // Tap on the first Pocket element
        app.collectionViews.containing(.cell, identifier: AccessibilityIdentifiers.FirefoxHomepage.TopSites.itemCell).children(matching: .cell).element(boundBy: 1).tap()
        waitUntilPageLoad()
        // The url textField is not empty
        XCTAssertNotEqual(app.textFields["url"].value as! String, "", "The url textField is empty")
    }
}
