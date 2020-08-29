//
//  PlantDetailViewController.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/24/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    // MARK: - Properties
    let plantImage = UIImageView()
    let nameLabel = UILabel()
    let plantNameTextfield = UITextField()
    let speciesLabel = UILabel()
    let plantSpeciesTextfield = UITextField()
    let frequencyLabel = UILabel()
    let plantWateringFrequencyTextfield = UITextField()
    let stack = UIStackView()
  
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let name = plant?.nickname else { return }
        navigationItem.title = "\(name)"
        addSubviews()
        updateViews()
        configurePlantImage()
        configureStackView()
        view.backgroundColor = ColorsHelper.mintGreen
    }
    
    // MARK: - Methods
    private func updateViews() {
        guard let plant = plant else { return }
        plantNameTextfield.text = plant.nickname
        plantSpeciesTextfield.text = plant.species
        plantWateringFrequencyTextfield.text = plant.h2ofrequency
        guard let image = plant.image else { return }
        plantImage.image = UIImage(data: image)
    }
    
    // MARK: - Helper Methods
    func addSubviews() {
        view.addSubview(plantImage)
        view.addSubview(stack)
    }
    
    func configurePlantImage() {
        // Configure
        plantImage.layer.cornerRadius = 10
        plantImage.clipsToBounds = true
        
        // Constraints
        plantImage.translatesAutoresizingMaskIntoConstraints = false
        plantImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        plantImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        plantImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        plantImage.widthAnchor.constraint(equalTo: plantImage.heightAnchor, multiplier: 1 / 1 ).isActive = true
    }
    
    func configureStackView() {
        // Add subviews
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(plantNameTextfield)
        stack.addArrangedSubview(speciesLabel)
        stack.addArrangedSubview(plantSpeciesTextfield)
        stack.addArrangedSubview(frequencyLabel)
        stack.addArrangedSubview(plantWateringFrequencyTextfield)
        // Configure
        configureStackViewItems()
        
        // Constraints
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 20).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func configureStackViewItems() {
        nameLabel.text = "Name"
        nameLabel.font = nameLabel.font.withSize(25)
        
        plantNameTextfield.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        plantNameTextfield.placeholder = "Enter plant name"
        plantNameTextfield.font = UIFont.systemFont(ofSize: 15)
        plantNameTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        plantNameTextfield.autocorrectionType = UITextAutocorrectionType.no
        plantNameTextfield.keyboardType = UIKeyboardType.default
        plantNameTextfield.returnKeyType = UIReturnKeyType.done
        plantNameTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        plantNameTextfield.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        plantNameTextfield.allowsEditingTextAttributes = false
        
        speciesLabel.text = "Species"
        speciesLabel.font = nameLabel.font.withSize(25)
        
        plantSpeciesTextfield.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        plantSpeciesTextfield.placeholder = "Enter plant species"
        plantSpeciesTextfield.font = UIFont.systemFont(ofSize: 15)
        plantSpeciesTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        plantSpeciesTextfield.autocorrectionType = UITextAutocorrectionType.no
        plantSpeciesTextfield.keyboardType = UIKeyboardType.default
        plantSpeciesTextfield.returnKeyType = UIReturnKeyType.done
        plantSpeciesTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        plantSpeciesTextfield.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        plantSpeciesTextfield.allowsEditingTextAttributes = false
        
        frequencyLabel.text = "Watering Frequency"
        frequencyLabel.font = nameLabel.font.withSize(25)
        
        plantWateringFrequencyTextfield.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        plantWateringFrequencyTextfield.placeholder = "Enter plant water frequency"
        plantWateringFrequencyTextfield.font = UIFont.systemFont(ofSize: 15)
        plantWateringFrequencyTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        plantWateringFrequencyTextfield.autocorrectionType = UITextAutocorrectionType.no
        plantWateringFrequencyTextfield.keyboardType = UIKeyboardType.default
        plantWateringFrequencyTextfield.returnKeyType = UIReturnKeyType.done
        plantWateringFrequencyTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        plantWateringFrequencyTextfield.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        plantWateringFrequencyTextfield.allowsEditingTextAttributes = false
    }
    
}
