//
//  MealsTableViewCell.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    @IBOutlet var imgVwMeal: UIImageView!
    @IBOutlet var lblMeals: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
