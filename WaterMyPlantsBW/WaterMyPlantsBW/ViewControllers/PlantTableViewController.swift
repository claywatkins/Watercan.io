//
//  PlantTableViewController.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/24/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit
import CoreData

class PlantTableViewController: UIViewController {
    
    // MARK: - Properties
    let refreshControl = UIRefreshControl()
    let tableView = UITableView()
    let popUpView = Popup()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let plantController = PlantController.shared
    
    lazy var fetchedResultsController: NSFetchedResultsController<Plant> = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nickname", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        
        do{
            try frc.performFetch()
        } catch {
            print("Error fetching")
        }
        return frc
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.delegate = self
        setUpNavBar()
        createTableView()
        setUpTableView()
        setupTableViewCell()
        setupViewAsthetics()
        setUpPopUpView()
        popUpView.plantNameTextfield.delegate = self
        popUpView.plantSpeciesTextfield.delegate = self
        popUpView.waterFrequencyTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if plantController.bearer == nil {
            let destinationVC = LoginViewController()
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
        tableView.reloadData()
    }
    
}

//MARK: - TableView Data Source

extension PlantTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantTableViewCell else { return UITableViewCell()}
        let plants = self.fetchedResultsController.object(at: indexPath)
        cell.plantNameLabel.text = plants.nickname
        cell.plantLastWatered.text = plants.h2ofrequency
        if let plantImage = plants.image {
            cell.plantImageView.image = UIImage(data: plantImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let plant = self.fetchedResultsController.object(at: indexPath)
            plantController.deletePlantFromServer(plant) { _ in
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            let moc = CoreDataStack.shared.mainContext
            moc.delete(plant)
            do {
                try moc.save()
            } catch {
                print("Error deleting Plant: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = PlantDetailViewController()
        destinationVC.plant = self.fetchedResultsController.object(at: indexPath)
        destinationVC.modalPresentationStyle = .automatic
        self.navigationController?.present(destinationVC, animated: true, completion: nil)
        // navigationController?.pushViewController(destinationVC, animated: true)
    }
}

