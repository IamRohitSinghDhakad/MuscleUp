//
//  HomeViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 19/06/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet var cvCategories: UICollectionView!
    @IBOutlet var imgVwFooter: UIImageView!
    @IBOutlet var vwContainImgFooter: UIView!
    @IBOutlet var hgtConsCvCategories: NSLayoutConstraint!
    @IBOutlet var cvTrainer: UICollectionView!
    
    var arrBannerData = [BannerModel]()
    var arrCategory = [CategoryModel]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cvCategories.delegate = self
        self.cvCategories.dataSource = self
        
        self.cvTrainer.delegate = self
        self.cvTrainer.dataSource = self
        // Do any additional setup after loading the view.
        
        self.call_WsGetBanner()
        self.call_WsGetCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
  
    @IBAction func actionBtnOpenSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.hgtConsCvCategories?.constant = self.cvCategories.contentSize.height
    }
    
    @IBAction func btnGoToMeal(_ sender: Any) {
        self.pushVc(viewConterlerId: "MealsViewController")
    }
}


extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvTrainer{
            return self.arrBannerData.count
        }else{
            return self.arrCategory.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.cvTrainer{
            let cellTrainer = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell", for: indexPath)as! TrainerCollectionViewCell
                
            let obj = self.arrBannerData[indexPath.row]
            let profilePic = obj.strBanner_image
            if profilePic != "" {
                let url = URL(string: profilePic)
                cellTrainer.imgvw.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }
            cellTrainer.lblTitle.text = ""
            cellTrainer.txtVwDesription.text = obj.strBanner_name
            
                
                return cellTrainer
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)as! HomeCollectionViewCell
            
            let objCategory = self.arrCategory[indexPath.row]
            
            cell.lblCategory.text = objCategory.strCategory_name
            
            let profilePic = objCategory.strCategory_image
            if profilePic != "" {
                let url = URL(string: profilePic)
                cell.imgVw.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }
            
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvCategories{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailViewController")as! CategoryDetailViewController
            vc.obj = self.arrCategory[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.cvTrainer{
            let noOfCellsInRow = 1

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: 350)
        }else{
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size + 15)
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

//MARK:- Call Webservice Get Banner

extension HomeViewController{
    
    func call_WsGetBanner(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getBanner, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let banner_data  = response["result"] as? [[String:Any]] {
                    if banner_data.count != 0{
                        for data in banner_data{
                            let obj = BannerModel.init(dict: data)
                            self.arrBannerData.append(obj)
                        }
                        self.cvTrainer.reloadData()
                    }
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                }
            }
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    func call_WsGetCategory(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
       // objWebServiceManager.showIndicator()
        
        let dict = ["sex":"Male"]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getCategory, params: dict, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let category_data  = response["result"] as? [[String:Any]] {
                    if category_data.count != 0{
                        
                        for data in category_data{
                            let obj = CategoryModel.init(dict: data)
                            self.arrCategory.append(obj)
                        }
                        self.cvCategories.reloadData()
                    }
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                }
            }
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
}
