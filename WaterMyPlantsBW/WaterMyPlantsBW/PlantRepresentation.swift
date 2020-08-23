//
//  PlantRepresentation.swift
//  WaterMyPlantsBW
//
//  Created by ronald huston jr on 8/23/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct PlantRepresentation: Codable {
    var id: Int
    var nickname: String
    var species: String
    var h2oFrequency: Int16
}
