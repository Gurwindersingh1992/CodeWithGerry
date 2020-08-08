//
//  MeViewModel.swift
//  SceneProject
//
//  Created by Gurwinder singh on 26/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import Foundation

class MeViewModel {
    
    static let shared  = MeViewModel()
    
    func txtHandler(model : Me, isLogin : Bool) -> (Bool, String){
        
        var status = true
        var error = ""
        if isLogin{
           let (loginStatus, loginError) =  handleLogin(loginModel: model)
            status = loginStatus
            error = loginError
        }else {
            let (signStatus , signUpError) =  handleSignUp(signUpModel: model)
            status = signStatus
            error = signUpError
        }
        return (status, error)
    }
    
    func handleLogin(loginModel : Me) -> (Bool, String){
        
        var status = true
        var error = ""
        if loginModel.email?.isEmpty ?? false{
            status = false
            error = "Please enter email address"
        }
       else if loginModel.password?.isEmpty ?? false{
            status = false
            error = "Please enter password"
        }
        return(status , error)
    }
    
    func handleSignUp(signUpModel : Me) -> (Bool, String){
        var status = true
        var error = ""
        
        if signUpModel.firstName?.isEmpty ?? false{
            status = false
            error = "Please enter first name"
        }
        else if signUpModel.lastName?.isEmpty ?? false{
            status = false
            error = "Please enter last name"
        }
        else if signUpModel.email?.isEmpty ?? false{
            status = false
            error = "Please enter email address"
        }
            
        else if signUpModel.DOB?.isEmpty ?? false{
            status = false
            error = "Please enter date of birth"
        }
        else if signUpModel.password?.isEmpty ?? false{
            status = false
            error = "Please enter password"
        }
        
        return(status, error)
    }
}
