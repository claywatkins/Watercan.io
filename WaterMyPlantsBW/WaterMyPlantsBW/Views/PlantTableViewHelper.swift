//
//  PlantTableViewHelper.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/24/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

extension PlantTableViewController{
    
    // MARK: - Helper Methods
    func createTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableViewCell() {
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: "PlantCell")
        tableView.rowHeight = 100
    }
    
    func setupViewAsthetics() {
        overrideUserInterfaceStyle = .dark
        tableView.backgroundColor = .systemGreen
        navigationItem.title = "Plants"
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        let barButtonAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlantPopup))
        navigationItem.setRightBarButton(barButtonAdd, animated: true)
    }
    
    @objc private func addPlantPopup(){
        animateScaleIn(desiredView: blurView)
        animateScaleInPopUpView()
        popUpView.addPlantImageView.image = UIImage(named: "defaultPlant2")
        popUpView.plantNameTextfield.text = ""
        popUpView.plantSpeciesTextfield.text = ""
        popUpView.waterFrequencyTextField.text = ""
        navigationItem.title = "Add Plant"
    }
    
    func createBlurView() {
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func setUpPopUpView() {
        createBlurView()
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.7)
        popUpView.backgroundColor = .white
        popUpView.layer.cornerRadius = 20
        popUpView.addComponentsToPopupView()
//        popUpView.configurePlantLabel()
        popUpView.configurePlantImageView()
        popUpView.configureAddImageButton()
        popUpView.configureStackView()
        popUpView.backgroundColor = .lightGray
    }
    
    /// Animates a view to scale in and display
    func animateScaleIn(desiredView: UIView) {
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView)
        desiredView.center = backgroundView.center
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        }
    }
    
    func animateScaleInPopUpView() {
        blurView.contentView.addSubview(popUpView)
        popUpView.center = blurView.center
        popUpView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.popUpView.alpha = 1
        }
    }
    
    func animateScaleOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { (success: Bool) in
            desiredView.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            
        }, completion: { _ in
            
        })
    }
    
}

extension PlantTableViewController: PlantAddedProtocol {
    func cancelTapped() {
        animateScaleOut(desiredView: popUpView)
        animateScaleOut(desiredView: blurView)
        navigationItem.title = "Plants"
    }
    
    func plantWasAdded() {
        guard let name = popUpView.plantNameTextfield.text, !name.isEmpty,
            let species = popUpView.plantSpeciesTextfield.text, !species.isEmpty,
            let wateringFrequency = popUpView.waterFrequencyTextField.text, !wateringFrequency.isEmpty,
            let image = popUpView.addPlantImageView.image
            else { return }
//        let newPlant = Plant(name: name, type: species, waterFrequency: wateringFrequency, image: image)
//        plantArray.append(newPlant)
        self.tableView.reloadData()
        animateScaleOut(desiredView: popUpView)
        animateScaleOut(desiredView: blurView)
        navigationItem.title = "Plants"
    }
    
    
    
}
