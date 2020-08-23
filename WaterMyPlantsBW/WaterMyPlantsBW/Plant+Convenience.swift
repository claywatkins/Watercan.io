//
//  Plant+Convenience.swift
//  WaterMyPlantsBW
//
//  Created by ronald huston jr on 8/23/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation
import CoreData

extension Plant {
    
    //  create a PlantRepresentation -> turn core data managed Plant object into a PlantReprepresentation object
    var plantRepresentation: PlantRepresentation? {
        guard let id = id,
        let nickname = nickname,
        let species = species,
            let h20Frequency = h2oFrequency else { return nil }
        
        return PlantRepresentation(id: id, nickname: nickname, species: species, h20Frequency: h20Frequency)
    }
    
    //  initializer to create a new managed object in Core Data
    @discardableResult convenience init(id: Int,
                                        nickname: String,
                                        species: String,
                                        h20Frequency: Int16,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.nickname = nickname
        self.species = species
        self.h20Frequency = h20Frequency
    }
    
    //  now convert a PlantRepresentation object [from JSON] into a managed object
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = plantRepresentation.id else { return nil }
        
        self.init(id: id,
                  nickname: plantRepresentation.nickname,
                  species: plantRepresentation.species,
                  h20Frequency: plantRepresentation.h20Frequency,
                  context: context)
    }
}
