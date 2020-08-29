//
//  WaterMyPlantsBWUITests.swift
//  WaterMyPlantsBWUITests
//
//  Created by Ian French on 8/26/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import XCTest

class WaterMyPlantsBWUITests: XCTestCase {
    let app = XCUIApplication()
    
    func testSignUpSignIn() {
        app.launch()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        usernameTextField.typeText("RandomUser1234")
        
        let phoneNumberTextField = app.textFields["Phone Number"]
        phoneNumberTextField.tap()
        phoneNumberTextField.tap()
        phoneNumberTextField.typeText("phoneNumber")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign Up"]/*[[".buttons.matching(identifier: \"Sign Up\").staticTexts[\"Sign Up\"]",".staticTexts[\"Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Sign Up Complete"].scrollViews.otherElements.buttons["OK"].tap()
        app.segmentedControls.buttons["Sign In"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons.matching(identifier: \"Sign In\").staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let plantsStaticText = XCUIApplication().navigationBars["Plants"].staticTexts["Plants"]
        plantsStaticText.tap()
        XCTAssert(plantsStaticText.exists)
    }
    
    func testAddPlantButtons() {
        app.launch()
        let app = XCUIApplication()
        app.segmentedControls.buttons["Sign In"].tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        usernameTextField.typeText("RandomUser1234")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons.matching(identifier: \"Sign In\").staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        app.navigationBars["Plants"].buttons["Add"].tap()
        
        let enterPlantNameTextField = app.textFields["Enter plant name"]
        enterPlantNameTextField.tap()
        enterPlantNameTextField.typeText("Tree")
        
        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        doneButton.tap()
        
        let enterPlantSpeciesTextField = app.textFields["Enter plant species"]
        enterPlantSpeciesTextField.tap()
        enterPlantSpeciesTextField.typeText("Birch")
        doneButton.tap()
        
        let enterPlantWaterFrequencyTextField = app.textFields["Enter plant water frequency"]
        enterPlantWaterFrequencyTextField.tap()
        enterPlantWaterFrequencyTextField.typeText("Twice Weekly")
        doneButton.tap()
        
        sleep(1)
        
        app.buttons["Add plant to collection"].tap()
        
        let cellName = app.tables.cells.staticTexts["Tree"]
        XCTAssert(cellName.exists)
        
    }
    
    func testClearTextField() {
        app.launch()
        let app = XCUIApplication()
        app.segmentedControls.buttons["Sign In"].tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        usernameTextField.typeText("RandomUser1234")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        usernameTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Username\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(usernameTextField.exists, "Textfield doesn't exist")
        XCTAssertEqual(usernameTextField.value as! String, "Username")
        
    }
    
    func testTapOnDetail() {
        app.launch()
        let app = XCUIApplication()
        
        app.segmentedControls.buttons["Sign In"].tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        usernameTextField.typeText("RandomUser1234")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons.matching(identifier: \"Sign In\").staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        
        app.tables.staticTexts["Test6"].tap()
        
        let wateringFrequencyStaticText = app.staticTexts["Watering Frequency"]
        wateringFrequencyStaticText.tap()
        
        XCTAssertEqual(wateringFrequencyStaticText.label, "Watering Frequency")
    }
    
    func testDeletePlant() {
        
        app.launch()
        let app = XCUIApplication()
        app.segmentedControls.buttons["Sign In"].tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        usernameTextField.typeText("RandomUser1234")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons.matching(identifier: \"Sign In\").staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        app.navigationBars["Plants"].buttons["Add"].tap()
        
        let enterPlantNameTextField = app.textFields["Enter plant name"]
        enterPlantNameTextField.tap()
        enterPlantNameTextField.typeText("Tree")
        
        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        doneButton.tap()
        
        let enterPlantSpeciesTextField = app.textFields["Enter plant species"]
        enterPlantSpeciesTextField.tap()
        enterPlantSpeciesTextField.typeText("Birch")
        doneButton.tap()
        
        let enterPlantWaterFrequencyTextField = app.textFields["Enter plant water frequency"]
        enterPlantWaterFrequencyTextField.tap()
        enterPlantWaterFrequencyTextField.typeText("Weekly")
        doneButton.tap()
        
        sleep(1)
        
        app.buttons["Add plant to collection"].tap()
        
        let WeeklyStaticText = app.tables.cells.containing(.staticText, identifier: "Tree").staticTexts["Weekly"]
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Weekly"]/*[[".cells.staticTexts[\"Weekly\"]",".staticTexts[\"Weekly\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["trailing0"]/*[[".cells",".buttons[\"Delete\"]",".buttons[\"trailing0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertFalse(WeeklyStaticText.exists)
        
    }
    
    func testCancelAddPlant() {
        app.launch()
        
        let app = XCUIApplication()
        app.segmentedControls.buttons["Sign In"].tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        usernameTextField.typeText("RandomUser1234")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons.matching(identifier: \"Sign In\").staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons.containing(.staticText, identifier: "Sign In").element.tap()
        
        let plantsNavigationBar = app.navigationBars["Plants"]
        plantsNavigationBar.buttons["Add"].tap()
        app.navigationBars["Add Plant"].buttons["Add"].tap()
        app.buttons["Cancel"].tap()
        plantsNavigationBar.staticTexts["Plants"].tap()
        XCTAssert(plantsNavigationBar.staticTexts["Plants"].exists)
    }
}
