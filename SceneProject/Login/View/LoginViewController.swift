//
//  ViewController.swift
//  SceneProject
//
//  Created by Gurwinder singh on 24/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    //MARK:- View All Outlets.
    
    fileprivate var param = [String : Any]()
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signupOutlet: UIButton!
    @IBOutlet weak var forgetOutlet: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    
    
    //MARK:- View Life cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()

        
    }
    
    //MARK:- View All Button Actions.
    
    
    @IBAction func onClickActions(_ sender: UIButton) {
        
        if sender.tag == 200{
            onClickLogin()
        }else if sender.tag == 201{
            pushToView()
        }
    }
    
    //MARK:- View All functions.
    
    
    func initView(){
        setBackGround()
        addDropShadow()
        roundImage()
    }
    
    
    func onClickLogin(){
        
        param["email"] = emailTxt.text
        param["phoneNumber"] = passwordTxt.text
        
        let (status, error) = MeViewModel.shared.txtHandler(model: Me.init(param: param), isLogin: true)
        if  status{
            print("Validation is Done")
        }else{
            self.customAlert(error: error)
        }
    }
    
    func roundImage(){
        
        imageView.makeRounded()
    }
    
    func addDropShadow(){
        
        loginOutlet.dropShadow(shadowValue: 4)
        signupOutlet.dropShadow(shadowValue: 4)
        backView.dropShadow(shadowValue: 4)

    }
    
    func customAlert(error : String){
        DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let popVC = storyBoard.instantiateViewController(withIdentifier: "POPViewController") as! POPViewController
            popVC.delegate = self
            popVC.modalTransitionStyle = .crossDissolve
            popVC.modalPresentationStyle = .overCurrentContext
            popVC.viewTitle = "Warning"
            popVC.viewDescription = error
            self.present(popVC,animated: true, completion: nil)
        }
    }
    
    func pushToView(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}

extension LoginViewController: onClickAlertAction {
    func setData(values: String) {
        print(values)
    }
}
