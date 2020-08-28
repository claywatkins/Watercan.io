//
//  User.swift
//  WaterMyPlantsBW
//
//  Created by BrysonSaclausa on 8/21/20.
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
