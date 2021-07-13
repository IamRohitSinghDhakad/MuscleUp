//
//  MealModel.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 26/06/21.
//

import UIKit

class MealModel: NSObject {

    var strMeal_plan_id:String = ""
    var strMeal_plan_image:String = ""
    var strMeal_plan_name:String = ""
    
    init(dict : [String:Any]) {
        
        if let meal_plan_id = dict["meal_plan_id"] as? String{
            self.strMeal_plan_id = meal_plan_id
        }else if let meal_plan_id = dict["meal_plan_id"] as? Int{
            self.strMeal_plan_id = "\(meal_plan_id)"
        }
    
        if let meal_plan_image = dict["meal_plan_image"] as? String{
            self.strMeal_plan_image = meal_plan_image
        }
        
        if let meal_plan_name = dict["meal_plan_name"] as? String{
            self.strMeal_plan_name = meal_plan_name
        }
        
    }
    
}


class MealDetailsModel: NSObject {

    var strMeal_id:String = ""
    var strMeal_image:String = ""
    var strMeal_name:String = ""
    var strMeal_plan_name:String = ""
    
    init(dict : [String:Any]) {
        
        if let meal_plan_id = dict["meal_plan_id"] as? String{
            self.strMeal_id = meal_plan_id
        }else if let meal_plan_id = dict["meal_plan_id"] as? Int{
            self.strMeal_id = "\(meal_plan_id)"
        }
    
        if let meal_image = dict["meal_image"] as? String{
            self.strMeal_image = meal_image
        }
        
        if let meal_name = dict["meal_name"] as? String{
            self.strMeal_name = meal_name
        }
        
        if let meal_plan_name = dict["meal_plan_name"] as? String{
            self.strMeal_plan_name = meal_plan_name
        }
        
        
        
    }
    
}
