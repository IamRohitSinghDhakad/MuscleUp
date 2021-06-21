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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBgColor()
    }
    
    
    
    
    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
