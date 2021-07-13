//
//  MealsDetailViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class MealsDetailViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnBackOnHeader: UIButton!
    @IBOutlet var imgVwMeal: UIImageView!
    @IBOutlet var lblMealTitle: UILabel!
    @IBOutlet var txtVwMealDesc: UITextView!
    
    var arrMealsPlans = [MealDetailsModel]()
    
    var strMealId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.call_WsGetMealsDescription(strPlanID: strMealId)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBgColor()
    }
    
    
    func setData(strObj:MealDetailsModel){
        
        self.lblMealTitle.text = strObj.strMeal_plan_name
        self.txtVwMealDesc.text = strObj.strMeal_name
        
        let profilePic = strObj.strMeal_image
        if profilePic != "" {
            let url = URL(string: profilePic)
            self.imgVwMeal.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "img"))
        }else{
            self.imgVwMeal.image = #imageLiteral(resourceName: "img")
        }
        
        
    }
    
    
    
    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
    

}

//MARK:- Call Webservice Get Meals List

extension MealsDetailViewController{
    
    func call_WsGetMealsDescription(strPlanID: String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dict = ["meal_plan_id":strPlanID,
                    "sex":objAppShareData.UserDetail.strGender]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getMealsPlanID, params: dict, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let category_data  = response["result"] as? [[String:Any]] {
                    if category_data.count != 0{
                        
                        for data in category_data{
                            let obj = MealDetailsModel.init(dict: data)
                            self.arrMealsPlans.append(obj)
                        }

                        if self.arrMealsPlans.count > 0{
                            self.setData(strObj: self.arrMealsPlans[0])
                        }
                    
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
