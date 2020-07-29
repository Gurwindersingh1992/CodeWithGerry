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
    var maritalStatus: String?
    var select : String?
    var phoneNumber: String?
    var Mood: String?
    
    
    init(param: [String: Any]) {
        self.firstName = param["firstName"] as? String
        self.lastName = param["lastName"] as? String
        self.email = param["email"] as? String
        self.DOB = param["DOB"] as? String
        self.maritalStatus = param["maritalStatus"] as? String
        self.select = param["select"] as? String
        self.phoneNumber = param["phoneNumber"] as? String
        self.Mood = param["Mood"] as? String
       
    }
}
