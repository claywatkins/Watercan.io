//
//  WaterMyPlantsBWTests.swift
//  WaterMyPlantsBWTests
//
//  Created by Ian French on 8/26/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import XCTest
@testable import WaterMyPlantsBW

class WaterMyPlantsBWTests: XCTestCase {


    func testSignUp() {

    }

    func testSignIn() {

    }



    func testCancelSignUpNotification() {

    }

    // PlantController
    func testFetchEntriesFromServer() {

        
    }

    // PlantTableViewHelper
    func testCancelTapped() {
        
    }
    
 // PlantTableViewHelper
    func testPlantWasAdded() {
        let newPlant = Plant(nickname: "Tree", species: "Elm", h2ofrequency: "Daily")
        XCTAssert(newPlant.nickname == "Tree")
        XCTAssert(newPlant.species == "Elm")
        XCTAssertNotNil(newPlant.h2ofrequency)
    }

    func testConvertPlantToRep() {
           let testPlant = Plant(nickname: "Fiddlehead", species: "Fern", h2ofrequency: "Daily")
           let representation = testPlant.plantRepresentation
           XCTAssertNotNil(representation)
           XCTAssert(representation?.nickname == "Fiddlehead")
           XCTAssert(representation?.species == "Fern")

       }
//Popup
    func testAddPhotoPickerController() {

    }

    func testImagePickerController() {


    }
}
