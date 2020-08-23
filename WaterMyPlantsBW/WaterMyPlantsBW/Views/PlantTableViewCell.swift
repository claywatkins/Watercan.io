//
//  PlantTableViewCell.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/21/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let plantImageView = UIImageView()
    let plantNameLabel = UILabel()
    let plantLastWatered = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureImageView()
        configureNameLabel()
        configureDateLabel()
        setImageConstraints()
        setNameLabelConstraints()
        setDateLabelConstraints()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func addSubViews() {
        addSubview(plantImageView)
        addSubview(plantNameLabel)
        addSubview(plantLastWatered)
    }
    
    private func configureImageView() {
        plantImageView.layer.cornerRadius = 10
        plantImageView.clipsToBounds = true
    }
    
    private func configureNameLabel() {
        plantNameLabel.numberOfLines = 0
        plantNameLabel.adjustsFontSizeToFitWidth = true
        plantNameLabel.font = plantNameLabel.font.withSize(26)
    }
    
    private func configureDateLabel() {
        plantLastWatered.numberOfLines = 0
        plantLastWatered.adjustsFontSizeToFitWidth = true
        plantLastWatered.font = plantLastWatered.font.withSize(22)
    }
    
    private func setImageConstraints() {
        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        plantImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plantImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        plantImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        plantImageView.widthAnchor.constraint(equalTo: plantImageView.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    private func setNameLabelConstraints() {
        plantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        plantNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plantNameLabel.leadingAnchor.constraint(equalTo: plantImageView.trailingAnchor, constant: 12).isActive = true
        plantNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setDateLabelConstraints() {
        plantLastWatered.translatesAutoresizingMaskIntoConstraints = false
        plantLastWatered.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plantLastWatered.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        plantLastWatered.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
}
