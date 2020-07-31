//
//  PageViewController.swift
//  SceneProject
//
//  Created by Gurwinder singh on 25/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    
    var arrayModel = [PageModel]()
    @IBOutlet weak var pageCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        
    }
    
    func setData(){
        
        arrayModel.append(PageModel.init(pageImage: UIImage(named: "firebase_database")!, pageTitle: "Titl", pagedescription: "This is the first Page to Show Firebase Databas"))
        
         arrayModel.append(PageModel.init(pageImage: UIImage(named: "firebase_storage")!, pageTitle: "Titl", pagedescription: "This is the first Page to Show Firebase Storage"))
        
         arrayModel.append(PageModel.init(pageImage: UIImage(named: "Firebase_notification")!, pageTitle: "Titl", pagedescription: "This is the first Page to Show Firebase Notification"))
        
        
        setCollection()
    }
    
    
    func setCollection(){
       
        
        pageCollection.delegate = self
        pageCollection.dataSource = self
            //  pageCollection.isUserInteractionEnabled = false
         pageCollection.register(UINib(nibName: "PageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageCollectionViewCell")
        
        
        if let direction = pageCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            direction.scrollDirection = .horizontal
        }
        
        pageCollection.reloadData()
        
        
        
        }
    
    func collectionBound(){
        
        let bound = pageCollection.bounds
        let contentOffset = CGFloat(floor(self.pageCollection.contentOffset.x + bound.size.width))
        moveCollectionFrame(contentOffset: contentOffset)
    }
    
    func moveCollectionFrame (contentOffset: CGFloat){
        
        let frame : CGRect = CGRect(x: contentOffset, y: self.pageCollection.contentOffset.y, width: self.pageCollection.frame.size.width, height: self.pageCollection.frame.size.height)
        self.pageCollection.scrollRectToVisible(frame, animated: true)
        
    }
}


extension PageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as! PageCollectionViewCell
        cell.delegate = self
        cell.model = arrayModel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: self.pageCollection.frame.size.width - 20, height: self.pageCollection.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension PageViewController: onclickBtnProtocol{
    func setData(model: PageModel) {
        print(model)
        collectionBound()
    }
}
