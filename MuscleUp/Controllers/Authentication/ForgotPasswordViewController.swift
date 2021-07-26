//
//  ForgotPasswordViewController.swift
//  MuscleUp
//
//  Created by Paras on 26/07/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackOnHeader(_ sender: Any) {
        onBackPressed()
    }
    
  

    @IBAction func btnContinue(_ sender: Any) {
        self.tfEmail.text = self.tfEmail.text?.trim()
        if self.tfEmail.text != ""{
            self.call_WsForgotPassword()
        }
        
    }
    
    
    func call_WsForgotPassword(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
    
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["email":self.tfEmail.text!]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_forgotPassword, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            var statusCode = Int()
            if let status = (response["status"] as? Int){
                statusCode = status
            }else  if let status = (response["status"] as? String){
                statusCode = Int(status)!
            }
            
            let message = (response["message"] as? String)
            print(response)
            if statusCode == MessageConstant.k_StatusCode{
                
                objAlert.showAlertCallBack(alertLeftBtn: "", alertRightBtn: "OK", title: "Alert", message: message ?? "Your request sent succesfully.", controller: self) {
                    self.onBackPressed()
                }
                
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
            }
           
            
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }

    
   }
}

