//
//  SwiftUI_Intro_UITests.swift
//  SwiftUI-Intro_UITests
//
//  Created by Tony on 2023-03-30.
//

import XCTest

// Name Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// test_[Struct]_[UIComponent]_[expected result]
// Test Structure: Give, When, Then

final class SwiftUI_Intro_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    let launchWithSignedIn = false

    override func setUpWithError() throws {
        continueAfterFailure = false
        if launchWithSignedIn {
            app.launchArguments = ["-UITest_startSignedIn"]
        }
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UITestingDemo_signUpButton_shouldNotSignIn() {
        
        if launchWithSignedIn {
            return
        }
        
        signUpAndSignIn(shouldTypeOnKeyBoard: false)
        
        let navBar = app.navigationBars["Welcome"]
        // Then
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITestingDemo_signUpButton_shouldSignIn() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        let navBar = app.navigationBars["Welcome"]

        // Then
        XCTAssertTrue(navBar.exists)
    }
    
    func test_SignInHomeView_showAlertButton_shouldDisplayAlert() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        tapAlertButton(shouldDismiss: false)
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        tapAlertButton(shouldDismiss: true)
        
        // Then
        let alertExists = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssertFalse(alertExists)
        
    }
    
    func test_SignInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        tapNavigationLink(shouldDismissDestination: false)
        
        let destinationText = app.staticTexts["Destination"]
        // Then
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        tapNavigationLink(shouldDismissDestination: true)
        
        // Then
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
    }
    
    private func tapAlertButton(shouldDismiss:Bool) {
        let alertButton = app.buttons["ShowAlertButton"]
        alertButton.tap()
        
        if shouldDismiss {
            let alert = app.alerts.firstMatch
            XCTAssertTrue(alert.exists)
            
            let okButton = app.buttons["OK"]
            let alertOKButtonExists = okButton.waitForExistence(timeout: 5)
            XCTAssertTrue(alertOKButtonExists)
            
            okButton.tap()
        }
    }
    
    private func tapNavigationLink(shouldDismissDestination: Bool) {
        let navLinkButton = app.buttons["NavigationLink"]
        navLinkButton.tap()
        
        if shouldDismissDestination {
            let backButton = app.navigationBars.buttons["Welcome"]
            backButton.tap()
        }
    }
    
    private func signUpAndSignIn(shouldTypeOnKeyBoard: Bool) {
        
        if launchWithSignedIn {
            return
        }
        
        let textField = app.textFields["SignUpTextField"]
        textField.tap()
        
        if shouldTypeOnKeyBoard {
            // Do not Connect Hardware keyboard
            let keyA = app.keys["A"]
            keyA.tap()
            let keya = app.keys["a"]
            keya.tap()
            keya.tap()
        }
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }
}
