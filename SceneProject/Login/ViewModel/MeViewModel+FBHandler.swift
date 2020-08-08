//
//  MeViewModel+FBHandler.swift
//  SceneProject
//
//  Created by Gurwinder singh on 04/08/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import Foundation
import Firebase

extension MeViewModel{
    
    typealias callback = ((_ status : Bool, _ error : String, _ result : AuthDataResult?)-> Void)
    typealias userImageandDatacallback = ((_ status : Bool, _ error : String, _ message: String)-> Void)
    
    func onClickAuthUser(email: String, password : String, result : @escaping (callback)) {
        
        FBDatabase.shared.authFBUser(email: email, password: password) { (status, error, dataResult) in
            result(status, error, dataResult)
        }
    }
    
    func onClickUserImageAndData(user : AuthDataResult,userImage: UIImageView, values : Me, result : @escaping (userImageandDatacallback)) {
        FBDatabase.shared.setUserImageAndData(user: user,userImage: userImage, values: values) { (status, error, message) in
            result(status, error, message)
        }
    }
    
    
    func onClickSignUser(email: String, password : String, result : @escaping (callback)){
        
        FBDatabase.shared.signAuthUser(email: email, password: password) { (status, error, dataResult) in
            result(status, error, dataResult)
        }
    }
}
