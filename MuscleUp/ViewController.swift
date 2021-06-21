//
//  ViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 18/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.pushVc(viewConterlerId: "LoginSignupViewController")
        }
       
        // Do any additional setup after loading the view.
    }


}

