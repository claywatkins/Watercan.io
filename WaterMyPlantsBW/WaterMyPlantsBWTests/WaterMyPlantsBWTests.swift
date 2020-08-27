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


    var newUser: String {
        return "Ian1"
    }

    func testSignUp() {
        let plantController = PlantController()
               let testUser1 = User(username: newUser, password: "ian123", phonenumber: "121-212-1212")
               print("User \(testUser1.username) has been created ")
               plantController.signUp(with: testUser1, completion: { error in
                   XCTAssertNil(error)
               })
    }

    func testSignIn() {
        let plantController = PlantController()
        let testUser2 = User(username: "ian2", password: "igf456", phonenumber: "223-232-2323")
               plantController.signIn(with: testUser2, completion: { error in
                   XCTAssertNil(error)
               })
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
