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

    func testAddPlantButtons() {

        app.launch()
        let app = XCUIApplication()

        app.segmentedControls.buttons["Sign In"].tap()

        let enterUserTextField = app.textFields["Username"]
        enterUserTextField.tap()
        enterUserTextField.typeText("igf")

        let enterPasswordTextField = app.secureTextFields["Password"]
        enterPasswordTextField.tap()
        enterPasswordTextField.typeText("igf1")

        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons.matching(identifier: \"Sign In\").staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Plants"].buttons["Add"].tap()




        let enterPlantNameTextField = app.textFields["Enter plant name"]
        enterPlantNameTextField.tap()
        enterPlantNameTextField.typeText("Tree")

        let enterPlantSpeciesTextField = app.textFields["Enter plant species"]
        enterPlantSpeciesTextField.tap()
        enterPlantSpeciesTextField.typeText("Birch")

        let enterPlantWaterFrequencyTextField = app.textFields["Enter plant water frequency"]
        enterPlantWaterFrequencyTextField.tap()
        enterPlantWaterFrequencyTextField.typeText("Twice Weekly")




        app.buttons["Add plant to collection"].tap()


        let cellName = app.tables.cells.staticTexts["Tree"]
        XCTAssert(cellName.exists)


    }

}


