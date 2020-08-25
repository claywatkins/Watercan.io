//
//  User.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int?
    let username: String
    let password: String
    let phoneNumber: String
}
