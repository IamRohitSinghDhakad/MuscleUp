//
//  CategoryModel.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 24/06/21.
//

import UIKit

class CategoryModel: NSObject {

    var strCategory_id: String = ""
    var strCategory_image:String = ""
    var strCategory_video:String = ""
    var strCategory_name:String = ""
    var strDesription:String = ""
    
    init(dict : [String:Any]) {
        
        if let banner_id = dict["category_id"] as? String{
            self.strCategory_id = banner_id
        }else if let banner_id = dict["category_id"] as? Int{
            self.strCategory_id = "\(banner_id)"
        }
    
        if let category_image = dict["category_image"] as? String{
            self.strCategory_image = category_image
        }
        
        if let category_name = dict["category_name"] as? String{
            self.strCategory_name = category_name
        }
        
        if let category_video = dict["category_video"] as? String{
            self.strCategory_video = category_video
        }
        
        if let description = dict["description"] as? String{
            self.strDesription = description
        }
    
    }
}
