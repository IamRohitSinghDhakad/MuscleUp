//
//  BannerModel.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 24/06/21.
//

import UIKit

class BannerModel: NSObject {

    var strBanner_id: String = ""
    var strBanner_image:String = ""
    var strBanner_name:String = ""
    
    init(dict : [String:Any]) {
        
        if let banner_id = dict["banner_id"] as? String{
            self.strBanner_id = banner_id
        }else if let banner_id = dict["banner_id"] as? Int{
            self.strBanner_id = "\(banner_id)"
        }
    
        if let banner_image = dict["banner_image"] as? String{
            self.strBanner_image = banner_image
        }
        
        if let banner_name = dict["banner_name"] as? String{
            self.strBanner_name = banner_name
        }
    
    }
    
}
