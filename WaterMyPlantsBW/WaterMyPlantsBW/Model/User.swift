//
//  User.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int?
    let username: String
    let password: String
    let phonenumber: String
    
    init(username: String, password: String, phonenumber: String){
        self.username = username
        self.password = password
        self.phonenumber = phonenumber
    }
}
