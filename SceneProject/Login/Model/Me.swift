//
//  Me.swift
//  SceneProject
//
//  Created by Gurwinder singh on 26/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import Foundation

class Me {
    var firstName: String?
    var lastName: String?
    var email: String?
    var DOB: String?
    var password : String?
    var userImage : String?
    
    
    init(param: [String: Any]) {
        self.firstName = param["firstName"] as? String
        self.lastName = param["lastName"] as? String
        self.email = param["email"] as? String
        self.DOB = param["DOB"] as? String
        self.password = param["password"] as? String
        self.userImage = param["userImage"] as? String
       
       
    }
}
