//
//  HomeCollectionViewCell.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var vwContainer: UIView!
    @IBOutlet var imgVw: UIImageView!
    @IBOutlet var lblCategory: UILabel!
    
    override  func awakeFromNib() {
        
        DispatchQueue.main.async {
            // corner radius
            self.vwContainer.layer.cornerRadius = 10
            // shadow
            self.vwContainer.layer.shadowColor = UIColor.lightGray.cgColor
            self.vwContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.vwContainer.layer.shadowOpacity = 0.9
            self.vwContainer.layer.shadowRadius = 5.0
          //  self.vwContainer.applyShadowWithCornerRadius(color: .lightGray, opacity: 1.0, radius: 5, edge: AIEdge.All, shadowSpace: 0, cornerRadius: 10)
        }
       
        
    }
    
}
