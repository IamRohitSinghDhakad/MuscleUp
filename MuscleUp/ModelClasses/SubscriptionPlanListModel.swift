//
//  SubscriptionPlanListModel.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 11/07/21.
//

import UIKit

class SubscriptionPlanListModel: NSObject {
    
    var strAmount : String = ""
    var strAndroidPackageIdentifier : String = ""
    var strCurrency : String = ""
    var strDescription: String = ""
    
    var strDuration : String = ""
    var strDuration_type : String = ""
    var strIosPackageIdentifier : String = ""
    var strPlanID: String = ""
    var strStatus: String = ""
    var strStripe_plan_id : String = ""
    var strStripe_product_id: String = ""
    var strTitle: String = ""
    var arrplanFeature = [String]()
    var strIsSubscribe : String = ""
    
    
 
    
    init(dict : [String : Any]) {
        
        if let amount = dict["price"]as? String{
            strAmount = amount
        }else if let amount = dict["price"]as? Int{
            strAmount = "\(amount)"
        }
       
        if let currency = dict["currency"]as? String{
            strCurrency = currency
        }
        
        if let arrDescription = dict["features"] as? [String] {
            print(arrDescription.count)
            for obj in arrDescription {
                arrplanFeature.append(obj)
            }
          

        }
        
        if let features = dict["features"]as? String{
            self.strDescription = features
        }
        
        if let duration = dict["validity"]as? String{
            strDuration = duration
        }else if let duration = dict["validity"]as? Int{
            strDuration = "\(duration)"
        }
        
      
        
        if let iosPackageIdentifier = dict["product_id"]as? String{
            strIosPackageIdentifier = iosPackageIdentifier
        }
        
        if let planID = dict["plan_id"]as? String{
            strPlanID = planID
        }
        
        if let status = dict["status"]as? String{
            strStatus = status
        }
        
        if let stripe_plan_id = dict["stripe_plan_id"]as? String{
            strStripe_plan_id = stripe_plan_id
        }
        
        if let stripe_product_id = dict["stripe_product_id"]as? String{
            strStripe_product_id = stripe_product_id
        }
        if let title = dict["plan_name"]as? String{
            strTitle = title
        }
        
    }
}

class SubscriptionPlanModel: NSObject {
   
    var strPlan_id : String = ""
    var strPlan_title : String = ""
    var strPlanAmount : String = ""
    var strEnd_date : String = ""
    var strStart_date : String = ""
    var strIs_cancelled : String = ""
    var strCurrency : String = ""
    var strDescription: String = ""
    var strPlanDuration : String = ""
    var strPlanDuration_type : String = ""
    var arrplanFeature = [String]()
    
    init(dict : [String : Any]) {
        
        if let plan_id = dict["plan_id"]as? String{
            strPlan_id = plan_id
        }
        if let plan_title = dict["plan_title"]as? String{
            strPlan_title = plan_title
        }
        if let plan_duration = dict["plan_duration"]as? String{
            strPlanDuration = plan_duration
        }
        
        if let plan_duration_type = dict["plan_duration_type"]as? String{
            strPlanDuration_type = plan_duration_type
        }
        
        if let start_date = dict["start_date"]as? String{
            strStart_date = start_date
        }
        
        if let end_date = dict["end_date"]as? String{
            strEnd_date = end_date
        }
        if let is_cancelled = dict["is_cancelled"]as? String{
            strIs_cancelled = is_cancelled
        }
        
        if let plan_amount = dict["plan_amount"]as? String{
            strPlanAmount = plan_amount
        }
        
        if let currency = dict["currency"]as? String{
            strCurrency = currency
        }
        
        if let arrDescription = dict["description"] as? [String] {
            print(arrDescription.count)
            for obj in arrDescription {
                arrplanFeature.append(obj)
            }
            
            
        }
        
        
    }
   
    
    
}
