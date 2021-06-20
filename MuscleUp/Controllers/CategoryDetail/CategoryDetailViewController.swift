//
//  CategoryDetailViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit
import AVFoundation

class CategoryDetailViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgVwVideo: UIImageView!
    @IBOutlet var lblTitleText: UILabel!
    @IBOutlet var txtVwDesc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func btnOnPlayMedia(_ sender: Any) {
    }
    

    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
}
