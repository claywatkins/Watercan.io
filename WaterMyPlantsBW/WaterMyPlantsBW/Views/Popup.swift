//
//  Popup.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/23/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//
//
import UIKit

class Popup: UIView {
    
    // MARK: - Properties
    let addPlantLabel = UILabel()
    let addPlantImageView = UIImageView()
    let addPlantImageButton = UIButton()
    let plantNameTextfield = UITextField()
    let plantSpeciesTextfield = UITextField()
    let waterFrequencyTextField = UITextField()
    let addPlantButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addComponentsToPopupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func addComponentsToPopupView() {
        addSubview(addPlantLabel)
        addSubview(addPlantImageView)
        addSubview(addPlantImageButton)
        addSubview(plantNameTextfield)
        addSubview(plantSpeciesTextfield)
        addSubview(waterFrequencyTextField)
        addSubview(addPlantButton)
    }
    
    func configurePlantLabel() {
        addPlantLabel.translatesAutoresizingMaskIntoConstraints = false
        addPlantLabel.font = addPlantLabel.font.withSize(32)
        addPlantLabel.text = "Add a Plant"
    }
    
}
