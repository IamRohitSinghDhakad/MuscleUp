//
//  LoginSignupViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 18/06/21.
//

import UIKit

class LoginSignupViewController: UIViewController {

    @IBOutlet var imgVwBg: UIImageView!
    @IBOutlet var imgVwLogo: UIImageView!
    
    @IBOutlet var vwFullName: UIView!
    @IBOutlet var vwEmail: UIView!
    @IBOutlet var vwForgotPassword: UIView!
    @IBOutlet var vwGender: UIView!
    @IBOutlet var vwPrivacypolicy: UIView!
    
    @IBOutlet var tfMobileNumber: UITextField!
    @IBOutlet var tfFullName: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
    @IBOutlet var imgVwprivacyPolicyCheck: UIImageView!
    @IBOutlet var imgVwMale: UIImageView!
    @IBOutlet var imgVwFemale: UIImageView!
    @IBOutlet var vwLoginBg: UIView!
    @IBOutlet var vwSignUpBg: UIView!
    
    @IBOutlet var btnLogin: UIButton!
    
    @IBOutlet var vwBtnBg: UIView!
    
    var isSignup:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpForLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // self.view.setBgColor()
    }

    
    func setUpForLogin(){
        self.vwFullName.isHidden = true
        self.vwEmail.isHidden = true
        self.vwForgotPassword.isHidden = false
        self.vwGender.isHidden = true
        self.vwPrivacypolicy.isHidden = true
        
        self.btnLogin.setTitle("Login", for: .normal)
        
        self.vwLoginBg.backgroundColor = MessageConstant.colorGreyBG
        self.vwSignUpBg.backgroundColor = UIColor.white
        
    }
    
    func setUpForSignUp(){
        self.vwFullName.isHidden = self.vwFullName.isHidden ? false : true
        self.vwEmail.isHidden = self.vwEmail.isHidden ? false : true
        self.vwForgotPassword.isHidden = self.vwForgotPassword.isHidden ? false : true
        self.vwGender.isHidden = self.vwGender.isHidden ? false : true
        self.vwPrivacypolicy.isHidden = self.vwPrivacypolicy.isHidden ? false : true
        self.btnLogin.setTitle(self.isSignup ? "Sign Up" : "Login", for: .normal)
        
        self.vwSignUpBg.backgroundColor = MessageConstant.colorGreyBG
        self.vwLoginBg.backgroundColor = UIColor.white
    }

    @IBAction func actionBtnLogin(_ sender: Any) {
        isSignup = false
        self.setUpForLogin()
    }
    @IBAction func actionBtnSignUp(_ sender: Any) {
        isSignup = true
        self.setUpForSignUp()
    }
    @IBAction func btnForgotPassword(_ sender: Any) {
        
    }
    @IBAction func btnMale(_ sender: Any) {
        UserDefaults.standard.setValue("Male", forKey: UserDefaults.Keys.strGender)
      
        
    }
    @IBAction func btnFemale(_ sender: Any) {
        UserDefaults.standard.setValue("Female", forKey: UserDefaults.Keys.strGender)
       
    }
    @IBAction func btnOnLoginSignup(_ sender: Any) {
        self.pushVc(viewConterlerId: "VerificationCodeViewController") 
    }
    
    @IBAction func btnRegisterLogin(_ sender: Any) {
        
    }
}

//MARK:- Validations
extension LoginSignupViewController{
    
    
    
}


extension UIView{
    func setBgColor(){
        if let value = UserDefaults.standard.value(forKey: UserDefaults.Keys.strGender)as? String{
            if value == "Male"{
                self.backgroundColor = UIColor.init(named: "AppBlue")
            }else{
                self.backgroundColor = UIColor.init(named: "AppPink")
            }
        }else{
            self.backgroundColor = UIColor.init(named: "AppBlue")
        }
        
    }
}
