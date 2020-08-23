//
//  PlantCollectionTableViewController.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/21/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

// MARK: - TODO:
// Delete this once we have models to pull from.
struct Plant{
    let name: String
    let type: String
    
    init(name: String, type: String){
        self.name = name
        self.type = type
    }
}

class PlantCollectionTableViewController: UITableViewController {
    
    // MARK: - Properties
    // MARK: - TODO:
    // Delete this once we have models to pull from.
    var plantArray: [Plant] = []
    let plant1 = Plant(name: "Test1", type: "Type1")
    let plant2 = Plant(name: "Test2", type: "Type2")
    
    func addPlant() {
        plantArray.append(plant1)
        plantArray.append(plant2)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAsthetics()
        setupTableViewCell()
        setUpNavBar()
        addPlant()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantTableViewCell else { return UITableViewCell()}
        cell.plantNameLabel.text = plantArray[indexPath.row].name
        cell.plantLastWatered.text = plantArray[indexPath.row].type
        cell.plantImageView.image = UIImage(named: "defaultPlant2")
        return cell
    }
    
    // MARK: - Methods
    private func setupTableViewCell() {
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: "PlantCell")
        tableView.rowHeight = 100
    }
    
    private func setupViewAsthetics() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .systemGreen
        navigationItem.title = "Plants"
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}

// MARK: - Extension
extension PlantCollectionTableViewController {
    func setUpNavBar() {
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
