//
//  ProfileViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var tfUserName: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var btnUserNameEdit: UIButton!
    @IBOutlet var btnEmailEdit: UIButton!
    @IBOutlet var btnPhoneEdit: UIButton!
    @IBOutlet var vwBtnBg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnUserNameEdit.tag = 0
        self.btnEmailEdit.tag = 1
        self.btnPhoneEdit.tag = 2
        
        self.disableAlltextField()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
    @IBAction func btnOnuploadImage(_ sender: Any) {
    }
    
    @IBAction func btnBackOnheader(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    
    @IBAction func btnOnEditUserDetail(_ sender: UIButton) {
        self.resignAllTextField()
        switch sender.tag {
        case 0:
            self.tfUserName.becomeFirstResponder()
            self.tfUserName.isUserInteractionEnabled = true
        case 1:
            self.tfEmail.becomeFirstResponder()
            self.tfEmail.isUserInteractionEnabled = true
        default:
            self.tfPhone.becomeFirstResponder()
            self.tfPhone.isUserInteractionEnabled = true
        }
        
    }
    
    func resignAllTextField(){
        self.tfUserName.resignFirstResponder()
        self.tfEmail.resignFirstResponder()
        self.tfPhone.resignFirstResponder()
    }
    
    func disableAlltextField(){
        self.tfUserName.isUserInteractionEnabled = false
        self.tfEmail.isUserInteractionEnabled = false
        self.tfPhone.isUserInteractionEnabled = false
    }
    
    @IBAction func btnOnSave(_ sender: Any) {
        
    }
    
}
