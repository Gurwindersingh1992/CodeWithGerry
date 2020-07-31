//
//  BaseViewController.swift
//  SceneProject
//
//  Created by Gurwinder singh on 25/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setBackGround (){
        // Because We are Sure to use this Image "use ! intead of Default value"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround")!)
    }
    
    func viewRadius ( view: UIView, radiusValue : CGFloat){
        DispatchQueue.main.async {
            view.layer.cornerRadius = radiusValue
        }
    }
    
    func formatter() -> DateFormatter{
        let format  = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        return format
    }
   }

