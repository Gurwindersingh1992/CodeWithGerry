//
//  POPViewController.swift
//  SceneProject
//
//  Created by Gurwinder singh on 25/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

protocol onClickAlertAction {
    func setData(values : String)
}


class POPViewController: BaseViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var okoutlet: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    var viewTitle : String = ""
    var viewDescription : String = ""
    var delegate : onClickAlertAction!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        addAnimation()
        imageRound()
    }
    
    
    func imageRound(){
        
        imageView.makeRounded()
    }
    
    func addAnimation(){
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(20)) {
            self.backView.shake()
            self.backView.dropShadow(shadowValue: 4)
            self.setValueToView(title:  self.viewTitle, description: self.viewDescription)
        }
    }
    
    func setValueToView(title : String, description: String ){
        
        DispatchQueue.main.async {
            self.titleLbl.text = title
            self.descriptionLbl.text = description
        }
    }
    
    @IBAction func onClickOk(_ sender: Any) {
        delegate.setData(values: "Working fine on Action")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
