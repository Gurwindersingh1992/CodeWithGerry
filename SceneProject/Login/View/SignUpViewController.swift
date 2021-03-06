    //
    //  SignUpViewController.swift
    //  SceneProject
    //
    //  Created by Gurwinder singh on 25/07/20.
    //  Copyright © 2020 Gurwinder singh. All rights reserved.
    //
    
    import UIKit
    import MobileCoreServices
    import Firebase
    
    class SignUpViewController: BaseViewController , UNUserNotificationCenterDelegate{
        
        //MARK:- View All Outlets.
        @IBOutlet weak var scroll: UIScrollView!
        
        
        var param = [String : Any]()
        @IBOutlet weak var saveOutlet: UIButton!
        @IBOutlet weak var lastNameTxt: UITextField!
        @IBOutlet weak var firstNameTxt: UITextField!
        @IBOutlet weak var dobTxt: UITextField!
        @IBOutlet weak var emailTxt: UITextField!
        @IBOutlet weak var passwordTxt: UITextField!
        @IBOutlet weak var userImage: UIImageView!
        
        var datePicker = UIDatePicker()
        
        //MARK:- View Life cycle.
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.setBackGround()
            initView()
            datePickerValues()
        }
        
        
        //MARK:- View All functions.
        
        
        func datePickerValues(){
            datePicker.datePickerMode = .date
            dobTxt.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerValuesChanged), for: .valueChanged)
            
        }
        
        //MARK:- View All Button Actions.
        
        @IBAction func onClickSelectImage(_ sender: Any) {
            actionSheet()
        }
        
        func actionSheet(){
            
            let alert = UIAlertController(title: "Chooese Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "open camera", style: .default, handler: { (handler) in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (handler) in
                self.openGallery()
            }))
            
            alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { (handler) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        func openCamera(){
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                let image = UIImagePickerController()
                image.allowsEditing = true
                image.sourceType = .camera
                image.mediaTypes = [kUTTypeImage as String]
                self.present(image, animated: true, completion: nil)
            }
        }
        
        func openGallery(){
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let image = UIImagePickerController()
                image.allowsEditing = true
                image.delegate = self
                self.present(image, animated: true, completion: nil)
            }
        }
        
        
        @IBAction func onClickSave(_ sender: Any) {
            checkValidation()
        }
        
        
        @IBAction func onClickBack(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        //MARK:- View All functions.
        
        
        @objc func datePickerValuesChanged(picker  : UIDatePicker){
            
            let obj = formatter()
            dobTxt.text = obj.string(from: picker.date)
        }
        
        
        
        func initView(){
            userImage.makeRounded()
            scroll.dropShadow(shadowValue: 4)
            saveOutlet.dropShadow(shadowValue: 4 )
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
        
        func checkValidation(){
            
            param["firstName"] =  firstNameTxt.text
            param["lastName"] =  lastNameTxt.text
            param["email"] =  emailTxt.text
            param["DOB"] =  dobTxt.text
            param["password"] =  passwordTxt.text
            
            
            // Use Tuple that return status and error
            
            let (status , error) =  MeViewModel.shared.txtHandler(model: Me.init(param: param), isLogin: false)
            if status{
              authUser(dict: param)
            }else{
                self.customAlert(error: error)
            }
        }
        
        func authUser(dict : [String : Any]){
            
            guard let userEmail = dict["email"] as? String, let userPassword = dict["password"] as? String else {
                return
            }
            MeViewModel.shared.onClickAuthUser(email: userEmail, password: userPassword) { (status, error, dataResult) in
                if status{
                    self.setDisplayName(result: dataResult,userDict: dict)
                }else {
                    self.customAlert(error: error)
                }
            }
        }
        
        func setDisplayName(result : AuthDataResult?, userDict : [String : Any]){
        
            if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest(){
                if let name = firstNameTxt.text{
                      currentUser.displayName = name
                }
                currentUser.commitChanges { (error) in
                    if let error  = error{
                        self.customAlert(error: error.localizedDescription)
                    }
                    else {
                        
                        self.setImageandData(user: result!, result: result, userDict: userDict)
                    }
                }
            }
        }
        
        func setImageandData(user: AuthDataResult,result : AuthDataResult?, userDict : [String : Any]){
            let model = Me(param: userDict)
            if let image = userImage{
                MeViewModel.shared.onClickUserImageAndData(user: user,userImage: image, values: model) { (status, error, message) in
                    if status{
                        print(message)
                    }else{
                        self.customAlert(error: error)
                    }
                }
            }
        }
        
    }
    
    extension SignUpViewController : onClickAlertAction{
        func setData(values: String) {
            print(values)
        }
    }
    
    extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print(info)
            
            let data  = convertFromUIimageTODict(info)
            if let editingImage = data[convertInfoKey((UIImagePickerController.InfoKey.editedImage))] as? UIImage{
                self.userImage.image = editingImage
                userImage.makeRounded()
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }
        
        func convertFromUIimageTODict( _ input :[UIImagePickerController.InfoKey : Any]) -> [String : Any]{
            return Dictionary(uniqueKeysWithValues: input.map({ key , value in (key.rawValue, value)
            }))
        }
        
        func convertInfoKey(_ input : UIImagePickerController.InfoKey) -> String{
            return input.rawValue
        }
    }
    
