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
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if AppSharedData.sharedObject().isLoggedIn {
                let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                let navController = UINavigationController(rootViewController: vc)
                navController.isNavigationBarHidden = true
                appDelegate.window?.rootViewController = navController
            }else{
                let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "LoginSignupViewController") as? LoginSignupViewController)!
                let navController = UINavigationController(rootViewController: vc)
                navController.isNavigationBarHidden = true
                appDelegate.window?.rootViewController = navController
            }
        }
       
        
        
        
        // Do any additional setup after loading the view.
    }


}

