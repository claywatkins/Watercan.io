//
//  WaterMyPlantsBWTests.swift
//  WaterMyPlantsBWTests
//
//  Created by Ian French on 8/26/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import XCTest
import CoreData
@testable import WaterMyPlantsBW

class WaterMyPlantsBWTests: XCTestCase {


    func testSignUp() {
        let plantController = PlantController()
               let testUser1 = User(username: "ian1", password: "ian123", phonenumber: "121-212-1212")
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

    func testSignUpNotification() {
        let loginVC = LoginViewController()
        loginVC.loginTypeSegmentedControl.selectedSegmentIndex = 0
        // Simulates the user tapping sign up with the current segment set to "Sign Up"
        let alertController = UIAlertController(title: "Sign Up Complete",
                                                message: "Please sign in",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        loginVC.present(alertController, animated: true)
        loginVC.loginType = .signIn
        loginVC.loginTypeSegmentedControl.selectedSegmentIndex = 1
        loginVC.signInButton.setTitle("Sign In", for: .normal)
        loginVC.phoneNumberTextField.isHidden = true
        
        XCTAssert(loginVC.phoneNumberTextField.isHidden)
        XCTAssert(loginVC.loginTypeSegmentedControl.selectedSegmentIndex == 1)
    }

    // PlantController
    func testFetchEntriesFromServer() {
        let plantController = PlantController()
            XCTAssertNotNil(plantController)

            let fetchedResultsController: NSFetchedResultsController<Plant> = {
                let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
                fetchRequest.sortDescriptors = [
                    NSSortDescriptor(key: "nickname", ascending: false)
                ]
                let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: CoreDataStack.shared.mainContext,
                                                     sectionNameKeyPath: "nickname",
                                                     cacheName: nil)
                frc.delegate = self as? NSFetchedResultsControllerDelegate
                try? frc.performFetch()
                return frc
            }()
            XCTAssertNotNil(fetchedResultsController.object)
        }

    // PlantTableViewHelper
    
    func testCancelTapped() {
        let nav = UINavigationController(rootViewController: LoginViewController())
        let destinationVC = PlantTableViewController()
        nav.setViewControllers([destinationVC], animated: true)
        nav.present(destinationVC, animated: true, completion: nil)
        destinationVC.dismiss(animated: true, completion: nil)
        XCTAssertFalse(destinationVC.isBeingPresented)
    }
    
    // PlantTableViewHelper
    
    func testPlantWasAdded() {
        let newPlant = Plant(nickname: "Tree", species: "Elm", h2ofrequency: "Daily")
        XCTAssert(newPlant.nickname == "Tree")
        XCTAssert(newPlant.species == "Elm")
        XCTAssertNotNil(newPlant.h2ofrequency)
    }

    func testConvertPlantToRepresentation() {
           let testPlant = Plant(nickname: "Fiddlehead", species: "Fern", h2ofrequency: "Daily")
           let representation = testPlant.plantRepresentation
           XCTAssertNotNil(representation)
           XCTAssert(representation?.nickname == "Fiddlehead")
           XCTAssert(representation?.species == "Fern")

       }
    
    //Popup
    
    func testAddPhotoPickerController() {
        let plant = Plant(nickname: "Test Plant", species: "Fern", h2ofrequency: "Daily")
        XCTAssert(plant.image == nil)
        let image = UIImage(named: "defaultPlant2")
        let imageData = image?.pngData()
        plant.image = imageData
        XCTAssert(plant.image != nil)
    }

    func testDeletePlant() {
        let newPlant: Plant = Plant(nickname: "Test Plant", species: "Thirsty", h2ofrequency: "Hourly")
        var mockPlants: [Plant] = []
        mockPlants.append(newPlant)
        XCTAssertFalse(mockPlants.isEmpty)
        mockPlants.removeAll()
        XCTAssert(mockPlants.isEmpty)
    }


    func testCreateNewUser() {
        let newUser = User(username: "M.Jackson", password: "ABC-123", phonenumber: "555-243-1999")
               XCTAssertNotNil(newUser.phonenumber)
               XCTAssertNotNil(newUser.username)
               XCTAssertNotNil(newUser.password)
    }
}
