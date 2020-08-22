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
    let plantImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let plantNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plantLastWatered: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        addConstraints()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func addSubViews() {
        self.contentView.addSubview(plantImageView)
        self.contentView.addSubview(plantNameLabel)
        self.contentView.addSubview(plantLastWatered)

    }
    
    private func addConstraints() {
        let imageViewTopConstraint = plantImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let imageViewLeadingConstraint = plantImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let plantNameLeadingConstraint = plantNameLabel.leadingAnchor.constraint(equalTo: plantImageView.trailingAnchor, constant: 10)
        let plantNameTopConstraint = plantNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
        let plantLastWateredTopConstraint = plantLastWatered.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
        let plantLastWateredTrailingConstraint = plantLastWatered.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
        imageViewTopConstraint,
        imageViewLeadingConstraint,
        plantNameTopConstraint,
        plantNameLeadingConstraint,
        plantLastWateredTopConstraint,
        plantLastWateredTrailingConstraint
        ])
    }
}
