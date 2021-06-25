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
    
    @IBOutlet var vwMobileNumber: UIView!
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
    
    //Variables
    var isSignup:Bool = false
    var strGender = ""
    var pickedImage = #imageLiteral(resourceName: "user")
    
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
        self.vwMobileNumber.isHidden = true
        self.vwFullName.isHidden = true
        self.vwEmail.isHidden = false
        self.vwForgotPassword.isHidden = false
        self.vwGender.isHidden = true
        self.vwPrivacypolicy.isHidden = true
        
        self.btnLogin.setTitle("Login", for: .normal)
        
        self.vwLoginBg.backgroundColor = MessageConstant.colorGreyBG
        self.vwSignUpBg.backgroundColor = UIColor.white
        
        self.imgVwprivacyPolicyCheck.image = #imageLiteral(resourceName: "box")
    }
    
    func setUpForSignUp(){
        
        
        self.vwFullName.isHidden = self.vwFullName.isHidden ? false : true
        self.vwEmail.isHidden = false//self.vwEmail.isHidden ? false : true
        self.vwMobileNumber.isHidden = self.vwMobileNumber.isHidden ? false : true
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
        self.strGender = "Male"
        self.imgVwMale.image = #imageLiteral(resourceName: "select")
        self.imgVwFemale.image = #imageLiteral(resourceName: "circle")
    }
    
    @IBAction func btnFemale(_ sender: Any) {
        UserDefaults.standard.setValue("Female", forKey: UserDefaults.Keys.strGender)
        self.strGender = "Female"
        self.imgVwMale.image = #imageLiteral(resourceName: "circle")
        self.imgVwFemale.image = #imageLiteral(resourceName: "select")
    }
    @IBAction func btnOnLoginSignup(_ sender: Any) {
        self.setValidation()
       // self.call_WsLogin()
        
       // ObjAppdelegate.HomeNavigation()
    }
    
    @IBAction func btnRegisterLogin(_ sender: Any) {
        self.setValidation()
    }
    @IBAction func btnCheckUncheckPrivacyPolicy(_ sender: Any) {
        if self.imgVwprivacyPolicyCheck.image == #imageLiteral(resourceName: "box"){
            self.imgVwprivacyPolicyCheck.image = #imageLiteral(resourceName: "check")
        }else{
            self.imgVwprivacyPolicyCheck.image = #imageLiteral(resourceName: "box")
        }
    }
}

//MARK:- Validations
extension LoginSignupViewController{
    
    // TextField delegate method
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.isSignup == false{
            if textField == self.tfMobileNumber{
                self.tfPassword.becomeFirstResponder()
                self.tfMobileNumber.resignFirstResponder()
            }
            else if textField == self.tfPassword{
                self.tfPassword.resignFirstResponder()
            }
            return true
        }else{
            if textField == self.tfMobileNumber{
                self.tfFullName.becomeFirstResponder()
                self.tfMobileNumber.resignFirstResponder()
            }else if textField == self.tfFullName{
                self.tfEmail.becomeFirstResponder()
                self.tfFullName.resignFirstResponder()
            }else if textField == self.tfEmail{
                self.tfPassword.becomeFirstResponder()
                self.tfEmail.resignFirstResponder()
            }else if textField == self.tfPassword{
                self.tfPassword.resignFirstResponder()
            }
            return true
        }
    }
    
    func setValidation(){
        
        self.tfEmail.text = self.tfEmail.text?.trim()
        self.tfMobileNumber.text = self.tfMobileNumber.text?.trim()
        self.tfFullName.text = self.tfFullName.text?.trim()
        self.tfPassword.text = self.tfPassword.text?.trim()
        
        if self.isSignup == false{
            if self.tfEmail.text!.isEmpty{
                objAlert.showAlert(message: MessageConstant.BlankEmail, title: "Alert", controller: self)
            }else if !objValidationManager.validateEmail(with: tfEmail.text!){
                objAlert.showAlert(message: MessageConstant.ValidEmail, title:MessageConstant.k_AlertTitle, controller: self)
            }else if self.tfPassword.text!.isEmpty{
                objAlert.showAlert(message: MessageConstant.BlankPassword, title: "Alert", controller: self)
            }else{
                self.call_WsLogin()
            }
        }else{
            if self.tfMobileNumber.text!.isEmpty{
                objAlert.showAlert(message: MessageConstant.BlankPhoneNo, title: "Alert", controller: self)
            }else if self.tfFullName.text!.isEmpty{
                objAlert.showAlert(message: MessageConstant.BlankUserName, title: "Alert", controller: self)
            }else if self.tfEmail.text!.isEmpty{
                objAlert.showAlert(message: MessageConstant.BlankEmail, title: "Alert", controller: self)
            }else if !objValidationManager.validateEmail(with: tfEmail.text!){
                objAlert.showAlert(message: MessageConstant.ValidEmail, title:MessageConstant.k_AlertTitle, controller: self)
            }else if self.tfPassword.text!.isEmpty{
                objAlert.showAlert(message: MessageConstant.BlankPassword, title: "Alert", controller: self)
            }else{
                self.callWebserviceForSignUp()
            }
            
        }
    }
    
}



//MARK:- Call Webservice Login

extension LoginSignupViewController{
    
    func call_WsLogin(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["email":self.tfEmail.text!,
                         "password":self.tfPassword.text!]as [String:Any]
        print(dicrParam)
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_Login, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
            
                let user_details  = response["result"] as? [String:Any]

                objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details ?? [:])
                objAppShareData.fetchUserInfoFromAppshareData()
                
                ObjAppdelegate.HomeNavigation()

            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                }
                
                
            }
            
            
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
}

//MARK:- CallWebservice
extension LoginSignupViewController{
    
    func callWebserviceForSignUp(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        self.view.endEditing(true)
        
        var imageData = [Data]()
        var imgData : Data?
        if self.pickedImage != nil{
            imgData = (self.pickedImage.jpegData(compressionQuality: 1.0))!
        }
        else {
            imgData = (self.pickedImage.jpegData(compressionQuality: 1.0))!
        }
        imageData.append(imgData!)
        
        let imageParam = ["user_image"]
        
        print(imageData)
        
        let dicrParam = ["name":self.tfFullName.text!,
                         "email":self.tfEmail.text!,
                         "mobile":self.tfMobileNumber.text!,
                         "sex":self.strGender,
                         "password":self.tfPassword.text!]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_SignUp, params: dicrParam, showIndicator: true, customValidation: "", imageData: imgData, imageToUpload: imageData, imagesParam: imageParam, fileName: "user_image", mimeType: "image/jpeg") { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
            
                let user_details  = response["result"] as? [String:Any]

                objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details ?? [:])
                objAppShareData.fetchUserInfoFromAppshareData()

            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
        }
    }
    
    

    
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
