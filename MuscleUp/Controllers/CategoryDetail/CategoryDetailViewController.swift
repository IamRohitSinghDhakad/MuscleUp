//
//  CategoryDetailViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit
import AVFoundation
import SDWebImage
import AVKit

class CategoryDetailViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgVwVideo: UIImageView!
    @IBOutlet var lblTitleText: UILabel!
    @IBOutlet var txtVwDesc: UITextView!
    

    var obj = CategoryModel(dict: [:])
    
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.text = obj.strCategory_name
        
        if objAppShareData.UserDetail.strGender == "Male"{
            self.lblTitleText.text = "\(obj.strCategory_name) exercise for men"
        }else{
            self.lblTitleText.text = "\(obj.strCategory_name) exercise for women"
        }
        
        let profilePic = obj.strCategory_image
        if profilePic != "" {
            let url = URL(string: profilePic)
            self.imgVwVideo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
           
        }
        self.txtVwDesc.text = obj.strDesription
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
    //MARK: - Setup
    func setupView() {
        let videoUrl = self.obj.strCategory_video
            if videoUrl != "" {
                guard let url = URL(string: videoUrl) else {
                    return
                }
                // Create an AVPlayer, passing it the HTTP Live Streaming URL.
                self.player = AVPlayer(url: url)
                self.playerViewController = AVPlayerViewController()
                self.playerViewController.player = player
                present(self.playerViewController, animated: true) {
                    self.player.play()
                }
            }
            else {
                
            }
            
        
    }
    
    

    @IBAction func btnOnPlayMedia(_ sender: Any) {
        
        if objAppShareData.UserDetail.strMembershipStatus == "1"{
            self.setupView()
        }else{
            objAlert.showAlertCallBack(alertLeftBtn: "Cancel", alertRightBtn: "OK", title: "Alert", message: "You don't have any membership plan \n Do you want to purchase?", controller: self) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController")as! SubscriptionViewController
                vc.isComingFrom = "Setting"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    

    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
}


extension CategoryDetailViewController{
    
    func call_WsGetProfile(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
       // objWebServiceManager.showIndicator()
        
        let dict = ["user_id":objAppShareData.UserDetail.strUserId]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getProfile, params: dict, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_data  = response["result"] as? [String:Any]{
                    
//                    if let name = user_data["name"]as? String{
//                        self.tfUserName.text = name
//                    }
                    
                    objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_data)
                    objAppShareData.fetchUserInfoFromAppshareData()
                    
                    
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
