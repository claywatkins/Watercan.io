//
//  Popup.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/23/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//
//
import UIKit

// MARK: - Protocol
protocol PlantAddedProtocol {
    func plantWasAdded()
    func cancelTapped()
}

class Popup: UIView{
    
    // MARK: - Properties
    let addPlantImageView = UIImageView()
    let addPlantImageButton = UIButton()
    let textFieldStack = UIStackView()
    let plantNameTextfield = UITextField()
    let plantSpeciesTextfield = UITextField()
    let waterFrequencyTextField = UITextField()
    let addPlantButton = UIButton()
    let cancelButton = UIButton()
    var delegate: PlantAddedProtocol?
    
    // MARK: - REQUIRED Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func addComponentsToPopupView() {
        addSubview(addPlantImageView)
        addSubview(addPlantImageButton)
        addSubview(textFieldStack)
    }
    
    func configurePlantImageView() {
        // Configure
        addPlantImageView.layer.cornerRadius = 10
        addPlantImageView.clipsToBounds = true
        addPlantImageView.backgroundColor = .lightGray
        
        // Constraints
        addPlantImageView.translatesAutoresizingMaskIntoConstraints = false
        addPlantImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        addPlantImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 63).isActive = true
        addPlantImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        addPlantImageView.widthAnchor.constraint(equalTo: addPlantImageView.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    func configureAddImageButton() {
        // Configure
        addPlantImageButton.setTitle("Add an image for your plant", for: .normal)
        addPlantImageButton.backgroundColor = .systemBlue
        addPlantImageButton.layer.cornerRadius = 15
        addPlantImageButton.setTitleColor(UIColor.white, for: .normal)
        addPlantImageButton.frame = CGRect(x: 0, y: 0, width: 250, height: 25)
        addPlantImageButton.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        
        // Constraints
        addPlantImageButton.translatesAutoresizingMaskIntoConstraints = false
        addPlantImageButton.topAnchor.constraint(equalTo: addPlantImageView.bottomAnchor, constant: 15).isActive = true
        addPlantImageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        addPlantImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    @objc private func addImageTapped() {
        addPhotoPickerController()
    }
    
    func configureStackView() {
        // Add to view
        textFieldStack.addArrangedSubview(plantNameTextfield)
        textFieldStack.addArrangedSubview(plantSpeciesTextfield)
        textFieldStack.addArrangedSubview(waterFrequencyTextField)
        textFieldStack.addArrangedSubview(addPlantButton)
        textFieldStack.addArrangedSubview(cancelButton)
        
        // Configure
        plantNameTextfield.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        plantNameTextfield.placeholder = "Enter plant name"
        plantNameTextfield.font = UIFont.systemFont(ofSize: 15)
        plantNameTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        plantNameTextfield.autocorrectionType = UITextAutocorrectionType.no
        plantNameTextfield.keyboardType = UIKeyboardType.default
        plantNameTextfield.returnKeyType = UIReturnKeyType.done
        plantNameTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        plantNameTextfield.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        plantSpeciesTextfield.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        plantSpeciesTextfield.placeholder = "Enter plant species"
        plantSpeciesTextfield.font = UIFont.systemFont(ofSize: 15)
        plantSpeciesTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        plantSpeciesTextfield.autocorrectionType = UITextAutocorrectionType.no
        plantSpeciesTextfield.keyboardType = UIKeyboardType.default
        plantSpeciesTextfield.returnKeyType = UIReturnKeyType.done
        plantSpeciesTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        plantSpeciesTextfield.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        waterFrequencyTextField.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        waterFrequencyTextField.placeholder = "Enter plant water frequency"
        waterFrequencyTextField.font = UIFont.systemFont(ofSize: 15)
        waterFrequencyTextField.borderStyle = UITextField.BorderStyle.roundedRect
        waterFrequencyTextField.autocorrectionType = UITextAutocorrectionType.no
        waterFrequencyTextField.keyboardType = UIKeyboardType.default
        waterFrequencyTextField.returnKeyType = UIReturnKeyType.done
        waterFrequencyTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        waterFrequencyTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        addPlantButton.setTitle("Add plant to collection", for: .normal)
        addPlantButton.backgroundColor = .systemBlue
        addPlantButton.layer.cornerRadius = 15
        addPlantButton.setTitleColor(UIColor.white, for: .normal)
        addPlantButton.frame = CGRect(x: 0, y: 0, width: 250, height: 25)
        addPlantButton.addTarget(self, action: #selector(addPlant), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .systemBlue
        cancelButton.layer.cornerRadius = 15
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 250, height: 25)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        // Constraints
        textFieldStack.translatesAutoresizingMaskIntoConstraints = false
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 20
        textFieldStack.distribution = .fillEqually
        textFieldStack.topAnchor.constraint(equalTo: addPlantImageButton.bottomAnchor, constant: 15).isActive = true
        textFieldStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textFieldStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    // Passing info back to parent VC
    @objc private func addPlant() {
        delegate?.plantWasAdded()
    }
    
    @objc private func cancelButtonTapped() {
        delegate?.cancelTapped()
    }
}

// MARK: - Extension
extension Popup: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    // allows us to present our photopicker
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }
    
    // delegate methods
    func addPhotoPickerController(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        let vc =  getTopMostViewController()
        vc!.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        addPlantImageView.image = image
    }
}


