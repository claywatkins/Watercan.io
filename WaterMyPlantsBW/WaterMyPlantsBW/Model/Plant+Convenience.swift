//
//  Plant+Convenience.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation
import CoreData

extension Plant {
    
    // Creating a codable plant object to be sent to endpoint
    var plantRepresentation: PlantRepresentation? {
        guard let nickname = nickname,
            let species = species,
            let h20Frequency = h20Frequency else { return nil}
        
        return PlantRepresentation(id: Int(id), userId: Int(userId), nickname: nickname, species: species, h20frequency: h20Frequency)
    }
    
    //  initializer to create a new managed object in Core Data
    @discardableResult convenience init(id: Int16,
                                        nickname: String,
                                        userId: Int16,
                                        species: String,
                                        h20Frequency: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.nickname = nickname
        self.userId = userId
        self.species = species
        self.h20Frequency = h20Frequency
    }
    
    // Turning a PlantRepresentation into a Plant object for saving to CoreData
    @discardableResult convenience init?(plantRepresentartion: PlantRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = plantRepresentartion.id,
            let userId = plantRepresentartion.userId
            else { return nil}
        
        self.init(id: Int16(id),
                  nickname: plantRepresentartion.nickname ?? "",
                  userId: Int16(userId),
                  species: plantRepresentartion.species ?? "",
                  h20Frequency: plantRepresentartion.h20frequency ?? "",
                  context: context)
    }
    
}
