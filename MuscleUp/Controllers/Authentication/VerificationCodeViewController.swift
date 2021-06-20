//
//  VerificationCodeViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 19/06/21.
//

import UIKit

class VerificationCodeViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet var tfOne: UITextField!
    @IBOutlet var tfTwo: UITextField!
    @IBOutlet var tfThree: UITextField!
    @IBOutlet var tfFour: UITextField!
    @IBOutlet var lblTimer: UILabel!
    
    //MARK:- App Lyf Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setOTPWork()
    }
    

    //MARK:- IBActions
    @IBAction func actionBtnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
    @IBAction func actionBtnOnSubmit(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
    }
    @IBAction func actionBtnResend(_ sender: Any) {
    }
    
}


//MARK:- OTP TextField Work
extension VerificationCodeViewController{
    
    func setOTPWork(){
        
        self.tfOne.delegate = self
        self.tfTwo.delegate = self
        self.tfThree.delegate = self
        self.tfFour.delegate = self
        
        self.tfOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.tfTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.tfThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.tfFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.tfOne.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
    }
    
    func _Validation(){
        self.tfOne.text = self.tfOne.text?.trim()
        self.tfTwo.text = self.tfTwo.text?.trim()
        self.tfThree.text = self.tfThree.text?.trim()
        self.tfFour.text = self.tfFour.text?.trim()
        
        if (self.tfOne.text?.isEmpty)!{
            let alertView = UIAlertController(title:MessageConstant.k_AlertTitle , message: MessageConstant.k_InvalidOTP, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: MessageConstant.k_OK, style: .default, handler: nil))
            self.present(alertView, animated:true, completion:nil)
            
        }else if (self.tfTwo.text?.isEmpty)!{
            let alertView = UIAlertController(title:MessageConstant.k_AlertTitle , message: MessageConstant.k_InvalidOTP, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: MessageConstant.k_OK, style: .default, handler: nil))
            self.present(alertView, animated:true, completion:nil)
            
        }else if (self.tfThree.text?.isEmpty)!{
            let alertView = UIAlertController(title:MessageConstant.k_AlertTitle , message: MessageConstant.k_InvalidOTP, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: MessageConstant.k_OK, style: .default, handler: nil))
            self.present(alertView, animated:true, completion:nil)
            
        }else if (self.tfFour.text?.isEmpty)!{
            let alertView = UIAlertController(title:MessageConstant.k_AlertTitle , message: MessageConstant.k_InvalidOTP, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: MessageConstant.k_OK, style: .default, handler: nil))
            self.present(alertView, animated:true, completion:nil)
        }else{
            //Merging all verification code numbers
            var strCompleteCode = String()
            if self.tfOne.text?.count != 0{
                strCompleteCode = self.tfOne.text!
            }
            if self.tfTwo.text?.count != 0{
                strCompleteCode += self.tfTwo.text!
            }
            if self.tfThree.text?.count != 0{
                strCompleteCode += self.tfThree.text!
            }
            if self.tfFour.text?.count != 0{
                strCompleteCode += self.tfFour.text!
            }
            print(strCompleteCode)
            
//            if self.isComingFrom == "SignUp"{
//                self.callRegisterUserOTPVerifyAPI(code: strCompleteCode)
//            }else{
//                self.callOTPVerifyAPI(code: strCompleteCode)
//            }
            
            
            
        }
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case self.tfOne:
                self.tfTwo.becomeFirstResponder()
            case self.tfTwo:
                self.tfThree.becomeFirstResponder()
            case self.tfThree:
                self.tfFour.becomeFirstResponder()
            case self.tfFour:
                self.tfFour.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case self.tfOne:
                self.tfOne.becomeFirstResponder()
            case self.tfTwo:
                self.tfOne.becomeFirstResponder()
            case self.tfThree:
                self.tfTwo.becomeFirstResponder()
            case self.tfFour:
                self.tfThree.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }

    
}
