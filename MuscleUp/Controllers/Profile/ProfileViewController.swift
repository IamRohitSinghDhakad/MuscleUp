//
//  ProfileViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class ProfileViewController: UIViewController,UINavigationControllerDelegate {
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var tfUserName: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var btnUserNameEdit: UIButton!
    @IBOutlet var btnEmailEdit: UIButton!
    @IBOutlet var btnPhoneEdit: UIButton!
    @IBOutlet var vwBtnBg: UIView!
    
    
    var imagePicker = UIImagePickerController()
    var pickedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker.delegate = self
        
        self.btnUserNameEdit.tag = 0
        self.btnEmailEdit.tag = 1
        self.btnPhoneEdit.tag = 2
        
        self.disableAlltextField()
        self.call_WsGetProfile()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
    @IBAction func btnOnuploadImage(_ sender: Any) {
        self.setImage()
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
        self.callWebserviceForUpdateProfile()
    }
}

// MARK:- UIImage Picker Delegate
extension ProfileViewController: UIImagePickerControllerDelegate{
    
    func setImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    // Open camera
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.modalPresentationStyle = .fullScreen
            self .present(imagePicker, animated: true, completion: nil)
        } else {
            self.openGallery()
        }
    }
    
    // Open gallery
    func openGallery()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.pickedImage = editedImage
            self.imgVwUser.image = self.pickedImage
            //  self.cornerImage(image: self.imgUpload,color:#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) ,width: 0.5 )
            
            self.makeRounded()
            if self.imgVwUser.image == nil{
                // self.viewEditProfileImage.isHidden = true
            }else{
                // self.viewEditProfileImage.isHidden = false
            }
            imagePicker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.pickedImage = originalImage
            self.imgVwUser.image = pickedImage
            self.makeRounded()
            // self.cornerImage(image: self.imgUpload,color:#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) ,width: 0.5 )
            if self.imgVwUser.image == nil{
                // self.viewEditProfileImage.isHidden = true
            }else{
                //self.viewEditProfileImage.isHidden = false
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    func cornerImage(image: UIImageView, color: UIColor ,width: CGFloat){
        image.layer.cornerRadius = image.layer.frame.size.height / 2
        image.layer.masksToBounds = false
        image.layer.borderColor = color.cgColor
        image.layer.borderWidth = width
        
    }
    
    func makeRounded() {
        
        self.imgVwUser.layer.borderWidth = 0
        self.imgVwUser.layer.masksToBounds = false
        //self.imgUpload.layer.borderColor = UIColor.blackColor().CGColor
        self.imgVwUser.layer.cornerRadius = self.imgVwUser.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        self.imgVwUser.clipsToBounds = true
    }
    
}

extension ProfileViewController{
    
    func call_WsGetProfile(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
       // objWebServiceManager.showIndicator()
        
        let dict = ["user_id":objAppShareData.UserDetail.strUserId]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getProfile, params: dict, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_data  = response["result"] as? [String:Any]{
                    
                    if let name = user_data["name"]as? String{
                        self.tfUserName.text = name
                    }
                    
                    if let email = user_data["email"]as? String{
                        self.tfEmail.text = email
                    }
                    
                    if let phone = user_data["mobile"]as? String{
                        self.tfPhone.text = phone
                    }
                    
                    if let user_image = user_data["user_image"]as? String{
                        let profilePic = user_image
                        if profilePic != "" {
                            let url = URL(string: profilePic)
                            self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "male"))
                        }
                    }
                    
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
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
extension ProfileViewController{
    
    func callWebserviceForUpdateProfile(){
        
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
            imgData = (self.pickedImage?.jpegData(compressionQuality: 1.0))!
        }
        else {
            imgData = (self.imgVwUser.image?.jpegData(compressionQuality: 1.0))!
        }
        imageData.append(imgData!)
        
        let imageParam = ["user_image"]
        
        print(imageData)
        
        let dicrParam = ["name":self.tfUserName.text!,
                         "user_id":objAppShareData.UserDetail.strUserId,
                         "mobile":self.tfPhone.text!]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_updateProfile, params: dicrParam, showIndicator: true, customValidation: "", imageData: imgData, imageToUpload: imageData, imagesParam: imageParam, fileName: "user_image", mimeType: "image/jpeg") { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
            
                let user_details  = response["result"] as? [String:Any]

                objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details ?? [:])
                objAppShareData.fetchUserInfoFromAppshareData()
                
                self.call_WsGetProfile()
                
              

            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
        }
    }
    
    

    
   }
