//
//  PrivacyPolicyViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    

    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
}
