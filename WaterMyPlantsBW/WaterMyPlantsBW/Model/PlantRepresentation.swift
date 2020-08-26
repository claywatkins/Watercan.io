//
//  PlantRepresentation.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct PlantRepresentation: Equatable, Codable {
    enum Key: String, CodingKey{
        case userId = "user_id"
    }
    let id: Int
    let userId: Int
    let nickname: String
    let species: String
    let h20frequency: String
}
