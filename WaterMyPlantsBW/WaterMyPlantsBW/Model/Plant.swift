//
//  Plant.swift
//  WaterMyPlantsBW
//
//  Created by BrysonSaclausa on 8/21/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct Plant: Codable, Equatable {
    
    //Coding Keys
    enum Keys: String, CodingKey {
        case name
        case id
        case userID
        case nickname
        case species
        case h20Frequency
        
        //Description Keys - sample for nested
        
//        enum TypeDescriptionKeys: String, CodingKey {
//            case type
//
//            enum TypeKeys: String, CodingKey {
//                case name
//            }
//        }
    }
    
     let name: String
     let id: Int
     let userID: Int
     let nickname: String
     let species: String
     let h2ofrequency: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        userID = try container.decode(Int.self, forKey: .userID)
        nickname = try container.decode(String.self, forKey: .nickname)
        species = try container.decode(String.self, forKey: .species)
        h2ofrequency = try container.decode(String.self, forKey: .h20Frequency)
        
    }
}
       //Nested Example
//           var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
//
//           var typeNames: [String] = []
//
//           while typesContainer.isAtEnd == false {
//               let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.self)
//
//               let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
//
//               let typeName = try typeContainer.decode(String.self, forKey: .name)
//               typeNames.append(typeName)
//           }
//
//           types = typeNames
