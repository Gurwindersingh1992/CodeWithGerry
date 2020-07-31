//
//  PageModel.swift
//  SceneProject
//
//  Created by Gurwinder singh on 31/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import Foundation
import UIKit

class PageModel {
    
    var pageImage : UIImage?
    var pageTitle : String?
    var pageDescription : String?
    
    init(pageImage : UIImage, pageTitle : String, pagedescription : String) {
        self.pageImage = pageImage
        self.pageTitle = pageTitle
        self.pageDescription = pagedescription
    }
}
