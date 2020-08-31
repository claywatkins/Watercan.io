//
//  PlantRepresentation.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct PlantRepresentation: Equatable, Codable {
    var id: Int?
    let nickname: String
    let species: String
    let h2ofrequency: String
}
