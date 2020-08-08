//
//  FBDatabase.swift
//  SceneProject
//
//  Created by Gurwinder singh on 04/08/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import Foundation
import Firebase


class FBDatabase {
    
    static let shared = FBDatabase()
    
    typealias callback = ((_ status : Bool, _ error : String, _ result : AuthDataResult?)-> Void)
    typealias userImageandDatacallback = ((_ status : Bool, _ error : String, _ message: String)-> Void)

    
    func authFBUser(email: String?, password: String?, result : @escaping (callback)){
        guard let useremail = email, let userpassword = password else {
            return
        }
        
        Auth.auth().createUser(withEmail: useremail, password: userpassword) { (dataResult, error) in
            if let error = error{
                result(false, error.localizedDescription, dataResult)
            }else {
                result(true, "", dataResult)
            }
        }
    }
    
    func setUserImageAndData(user : AuthDataResult,userImage: UIImageView, values : Me, result : @escaping (userImageandDatacallback) ){
        
        let imageId = UUID().uuidString
        let ref = Storage.storage().reference().child("\(imageId).png")
        if let image = userImage.image , let data = image.pngData(){
            ref.putData(data, metadata: nil) { (metaData, error) in
                if let error = error{
              
                    result(false, error.localizedDescription, "")
                }else {
                    ref.downloadURL { (url, error) in
                        if let error = error{
                            result(false, error.localizedDescription, "")
                        }else{
                            if  let string =  url?.absoluteString {
                                self.setUserValues(user: user, absolute: string, values: values) { (status, error, message) in
                                      result(status, error , message)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func setUserValues(user: AuthDataResult, absolute : String, values : Me, result : @escaping (userImageandDatacallback)){
        
        var param = [String : Any]()
        if let image = absolute as? String{
            values.userImage = image
            param["userImage"] = values.userImage
        }
         param["firstName"] = values.firstName
         param["lastName"] = values.lastName
         param["DOB"] = values.DOB
         param["password"] = values.password
        
        guard let uid: String = user.user.uid else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(uid)
        ref.updateChildValues(param) { (error, ref) in
            if let error = error{
                result(false , error.localizedDescription , "")
            }else {
                result(true , "" , "user is registered successfully")
            }
        }
    }
   
    
    func signAuthUser(email: String?, password: String?, result : @escaping (callback)){
        
        guard let useremail = email, let userpassword = password else {
            return
        }
        Auth.auth().signIn(withEmail: useremail, password: userpassword) { (dataResult, error) in
            if let error = error{
                result(false, error.localizedDescription, dataResult)
            }else {
                result(true, "", dataResult)
            }
        }
    }
}
