//
//  SignUpViewController.swift
//  SceneProject
//
//  Created by Gurwinder singh on 25/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

     //MARK:- View All Outlets.
    @IBOutlet weak var scroll: UIScrollView!
    
    var param = [String : Any]()
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var moodTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var selectSexTxt: UITextField!
    @IBOutlet weak var maritalStatusTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
   
    
     //MARK:- View Life cycle.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackGround()
        initView()
    }
    
    
    //MARK:- View All functions.
    
    func initView(){
        scroll.dropShadow(shadowValue: 4)
        saveOutlet.dropShadow(shadowValue: 4)
    }
    
     //MARK:- View All Button Actions.
    
    @IBAction func onClickSave(_ sender: Any) {
         checkValidation()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
     //MARK:- View All functions.
    
  
    
    func checkValidation(){
        
        param["firstName"] =  firstNameTxt.text
        param["lastName"] =  lastNameTxt.text
        param["email"] =  emailTxt.text
        param["DOB"] =  dobTxt.text
        param["maritalStatus"] =  maritalStatusTxt.text
        param["select"] =  selectSexTxt.text
        param["phoneNumber"] =  phoneNumberTxt.text
        param["Mood"] =  moodTxt.text
       
        // Use Tuple that return status and error
        
       let (status , error) =  MeViewModel.shared.txtHandler(model: Me.init(param: param), isLogin: false)
        if status{
        print("Validation is Done")
        }else{
        print(error)
        }
    }
}
