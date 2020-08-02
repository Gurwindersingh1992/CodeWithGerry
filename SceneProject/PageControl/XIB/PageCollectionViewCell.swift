//
//  PageCollectionViewCell.swift
//  SceneProject
//
//  Created by Gurwinder singh on 31/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

protocol onclickBtnProtocol {
    func setData(model : PageModel, isBack : Bool)
}

class PageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backOutlet: UIButton!
    @IBOutlet weak var backView: UIView!
    var delegate : onclickBtnProtocol?
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var model : PageModel?{
        didSet{
            self.image.image = model?.pageImage
            self.descLbl.text = model?.pageDescription
            self.nextOutlet.dropShadow(shadowValue: 4)
        }
    }
    
    @IBAction func OnClickNext(_ sender: Any) {
        delegate?.setData(model: model!, isBack: false)
    }
    
    @IBAction func OnClickback(_ sender: Any) {
        delegate?.setData(model: model!, isBack: true)
    }
}
