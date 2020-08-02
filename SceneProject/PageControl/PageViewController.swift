//
//  PageViewController.swift
//  SceneProject
//
//  Created by Gurwinder singh on 25/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import UIKit

class PageViewController: BaseViewController {
    
    
    var arrayModel = [PageModel]()
    @IBOutlet weak var pageCollection: UICollectionView!
    
    @IBOutlet weak var page: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackGround()
        setData()
        pageCollection.dropShadow(shadowValue: 6)
        
    }
    
    func setData(){
        
        arrayModel.append(PageModel.init(pageImage: UIImage(named: "manual")!, pageTitle: "Titl", pagedescription: "This is the User Manual guide to show How we store and manage our data"))
        
        
        arrayModel.append(PageModel.init(pageImage: UIImage(named: "firebase")!, pageTitle: "Titl", pagedescription: "All the information is stotre in Firebase database"))
        
        arrayModel.append(PageModel.init(pageImage: UIImage(named: "storage")!, pageTitle: "Titl", pagedescription: "user images are also store in firbase Storage"))
        
        arrayModel.append(PageModel.init(pageImage: UIImage(named: "Firebase_notification")!, pageTitle: "Titl", pagedescription: "Notification will be triggered according to the functionaity"))
        
        
        page.numberOfPages = arrayModel.count
        setCollection()
    }
    
    
    func setCollection(){
        
        
        pageCollection.delegate = self
        pageCollection.dataSource = self
        pageCollection.isScrollEnabled = false
        pageCollection.register(UINib(nibName: "PageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageCollectionViewCell")
        
        
        if let direction = pageCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            direction.scrollDirection = .horizontal
        }
        
        pageCollection.reloadData()
        
    }
    
    func onClickCollectionBack(){
        
        let bound = pageCollection.bounds
        let contentOffset = CGFloat(floor(self.pageCollection.contentOffset.x - bound.size.width))
        moveCollectionFrame(contentOffset: contentOffset)
    }
    
    func collectionBound(){
        if page.currentPage == arrayModel.count - 1{
        pushToView()
        }
        else {
            let bound = pageCollection.bounds
            let contentOffset = CGFloat(floor(self.pageCollection.contentOffset.x + bound.size.width))
            moveCollectionFrame(contentOffset: contentOffset)
        }
        
    }
    
    func moveCollectionFrame (contentOffset: CGFloat){
        
        let frame : CGRect = CGRect(x: contentOffset, y: self.pageCollection.contentOffset.y, width: self.pageCollection.frame.size.width, height: self.pageCollection.frame.size.height)
        self.pageCollection.scrollRectToVisible(frame, animated: true)
        
    }
    
    func pushToView(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}


extension PageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        page.currentPage = indexPath.row
        let cellData = cell as! PageCollectionViewCell
        
       
        if page.currentPage == 0{
            cellData.backOutlet.isHidden = true
        }else {
            cellData.backOutlet.isHidden = false
        }
    }
    
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
    func setData(model: PageModel, isBack : Bool) {
        
        if isBack{
            onClickCollectionBack()
        }else {
            collectionBound()
        }
    }
}
