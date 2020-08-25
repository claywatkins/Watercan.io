//
//  PlantTableViewController.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/24/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

// MARK: - TODO:
// Delete this once we have models to pull from.
//struct Plant{
//    let name: String
//    let type: String
//    let waterFrequency: String
//    let image: UIImage
//    
//    init(name: String, type: String, waterFrequency: String, image: UIImage){
//        self.name = name
//        self.type = type
//        self.waterFrequency = waterFrequency
//        self.image = image
//    }
//}

class PlantTableViewController: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    let popUpView = Popup()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    // MARK: - TODO:
    // Delete this once we have data to pull from.
    //    var plantArray: [Plant] = []
    //    let plant1 = Plant(name: "Test1", type: "Type1", waterFrequency: "Daily", image: UIImage(named: "defaultPlant2")!)
    //    let plant2 = Plant(name: "Test2", type: "Type2", waterFrequency: "Daily", image: UIImage(named: "defaultPlant2")!)
    //    func addPlant() {
    //        plantArray.append(plant1)
    //        plantArray.append(plant2)
//}

// MARK: - LifeCycle
override func viewDidLoad() {
    super.viewDidLoad()
    popUpView.delegate = self
    createTableView()
    setUpTableView()
    setupTableViewCell()
    setupViewAsthetics()
    setUpNavBar()
//    addPlant()
    setUpPopUpView()
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
}

}
//MARK: - TableView Data Source
extension PlantTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return plantArray.count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantTableViewCell else { return UITableViewCell()}
        //        cell.plantNameLabel.text = plantArray[indexPath.row].name
        //        cell.plantLastWatered.text = plantArray[indexPath.row].type
        //        cell.plantImageView.image = plantArray[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = PlantDetailViewController()
        //        destinationVC.plant = plantArray[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

