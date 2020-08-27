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
            let h20Frequency = h2ofrequency else { return nil}
        
        return PlantRepresentation(nickname: nickname, species: species, h2ofrequency: h20Frequency)
    }
    
    //  initializer to create a new managed object in Core Data
    @discardableResult convenience init(
                                        nickname: String,
                                        species: String,
                                        h2ofrequency: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.nickname = nickname
        self.species = species
        self.h2ofrequency = h2ofrequency
    }
    
    // Turning a PlantRepresentation into a Plant object for saving to CoreData
    @discardableResult convenience init?(plantRepresentartion: PlantRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        

        
        self.init(nickname: plantRepresentartion.nickname,
                  species: plantRepresentartion.species,
                  h2ofrequency: plantRepresentartion.h2ofrequency,
                  context: context)
    }
    
}
