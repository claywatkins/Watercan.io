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
    
    var id: Int?
    var userId: Int?
    var nickname: String?
    var species: String?
    var h20frequency: String?
}
