//
//  SubscriptionViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit
import StoreKit
import SVProgressHUD

class SubscriptionViewController: UIViewController {

    @IBOutlet var cvSuscription: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    
    
    var isComingFrom = ""
    var strIsSubscribe = ""
    var strIsCancel = ""
    var strPlanId = ""
    var strExpireTime = ""
    var strPlanAmount = ""
    var strPlanTitle = ""
    var strProductId = ""
    
    var myProduct:  SKProduct?
    
    var arrPlanList = [SubscriptionPlanListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cvSuscription.delegate = self
        self.cvSuscription.dataSource = self
        
        self.callWebserviceGetPlanList()
        // Do any additional setup after loading the view.
        
//        RDIAPHandler.shared.setProductIds(ids: ["com.ios.MuscleUp_silverPlan"])
//
//        RDIAPHandler.shared.fetchAvailableProducts { product in
//            print(product)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBgColor()
       // self.fetchProduct()
    }
    
    
   
    
    @IBAction func btnOpenSideMenu(_ sender: Any) {
        if isComingFrom == "Setting"{
            self.isComingFrom = ""
            self.navigationController?.popViewController(animated: true)
        }else{
            self.sideMenuController?.revealMenu()
        }
        
    }
    
  
}

extension SubscriptionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPlanList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscriptionCollectionViewCell", for: indexPath)as! SubscriptionCollectionViewCell
        
        let obj = self.arrPlanList[indexPath.row]
        
        cell.lblPrice.text = "$" + obj.strAmount
        if obj.strTitle.contains("Monthly"){
            cell.lblValidity.text = "monthly"
        }else{
            cell.lblValidity.text = "Yearly"
        }
        
        cell.btnChoose.tag = indexPath.row
        cell.btnChoose.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)

        cell.tblSubscriptionList.reloadData()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let noOfCellsInRow = 1

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            let sizeHeight = Int((collectionView.bounds.height - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: sizeHeight)
    }
    
    
    @objc func connected(sender: UIButton){
        
        SVProgressHUD.show(withStatus: "Please wait...")
        let objID = self.arrPlanList[sender.tag]
        self.strPlanAmount = objID.strAmount
        self.strProductId = "com.ios.MuscleUp_MonthlySubscription"//objID.strIosPackageIdentifier
        self.strPlanTitle = objID.strTitle
        
        PurchaseHelper.payForPackage(packageId: self.strProductId, onSuccss: {[weak self] (PurchaseDetails, encodedString , receipt_Data) in
            guard let weakSelf = self else{return}
            SVProgressHUD.dismiss()
            weakSelf.upload(receipt: receipt_Data, SubscriptionPlanId: "\(objID.strPlanID)" )//
        })
        { (errorAlert) in
            print(errorAlert)
            SVProgressHUD.dismiss()
            
        }
        
    }
    
}

extension SubscriptionViewController{
    
    //Mark: Upload Subscription Receipt
    func upload(receipt data: Data , SubscriptionPlanId : String) {
        
        let receiptdataBase64 = data.base64EncodedString()
        print(self.strProductId)
        print(receiptdataBase64,SubscriptionPlanId)
        self.callWebservice_ForPurchasePlan(planId: SubscriptionPlanId, planTitle: self.strPlanTitle , planAmount: self.strPlanAmount , encodedString: receiptdataBase64, productId: self.strProductId,purchaseDetails: [:])
    }
 
}



extension SubscriptionViewController{
    //MARK:- Get Plan List
    func callWebserviceGetPlanList(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        

        objWebServiceManager.showIndicator()
        objWebServiceManager.requestGet(strURL: WsUrl.url_getSubscriptionList, params: nil, queryParams: [:], strCustomValidation: "", success: {response in
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            self.arrPlanList.removeAll()
            objWebServiceManager.hideIndicator()
            if status == MessageConstant.k_StatusCode{
                if let data = response["result"] as? [[String:Any]]{
                    
                        for obj in data{
                            let objSubsc = SubscriptionPlanListModel.init(dict: obj)
                                self.arrPlanList.append(objSubsc)
                        }
                    
                    self.cvSuscription.reloadData()
                    
                }
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
            
           
            
//            if status == k_success{
//                self.strPlanId =  UserDefaults.standard.value(forKey: UserDefaults.Keys.PlanID) as? String ?? ""
//
//                if let data = response["data"] as? [String:Any]{
//                    if let arr = data["plan_list"] as? [[String:Any]]{
//                        for obj in arr{
//                            let objSubsc = SubscriptionPlanListModel.init(dict: obj)
//                            if objSubsc.strPlanID == self.strPlanId{
//                                self.arrPlanList.append(objSubsc)
//
//                            }else if objSubsc.strStatus == "1"{
//                                self.arrPlanList.append(objSubsc)
//                            }
//
//
//                        }
//                    }
//                }
//
//
//                if self.arrPlanList.count == 0{
//                    self.viewNoPlan.isHidden = false
//                }else{
//                    self.viewNoPlan.isHidden = true
//                }
//
//                 self.cvSubscription.reloadData()
//                objWebServiceManager.hideIndicator()
//
//            }else{
//                objWebServiceManager.hideIndicator()
//
//                objAppShareData.showAlert(title: kAlertTitle.localize, message: message, view: self)
//
//            }
          
        }, failure: { (error) in
            print(error)
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "Message", title: "Alert", controller: self)
        })
    }
    
    
    
    //MARK:- purchase plan Api
    
       func callWebservice_ForPurchasePlan(planId:String,planTitle:String,planAmount:String,encodedString:String,productId:String,purchaseDetails: [String:String]){
           
        self.view.endEditing(true)
        objWebServiceManager.showIndicator()
        
        //user_id=5&plan_id=1&txn_id=2527dsdadadf
        let param = ["plan_id":planId,
                     "user_id":objAppShareData.UserDetail.strUserId,
                    // "platform_type": "0",
                    // "payment_platform_type":"0" ,
                    // "platform_identifier":"com.qvazon",
                    // "transaction_detail":"",
                    // "platform_product_id":productId,
                    // "purchase_token":encodedString,
                     "txn_id":encodedString
                   //  "plan_title":planTitle,
                   //  "plan_amount":planAmount
        ] as [String : Any] //
        
       objWebServiceManager.requestPost(strURL: WsUrl.url_validatePurchase, queryParams: [:], params: param, strCustomValidation: "", showIndicator: false, success: {response in
            
        let status = (response["status"] as? Int)
        let message = (response["message"] as? String)
        
           objWebServiceManager.hideIndicator()
        
        if status == MessageConstant.k_StatusCode {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            appDelegate.window?.rootViewController = navController
        }else{
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
        }
        
        }, failure: { (error) in
            print(error)
            objWebServiceManager.hideIndicator()
           // objAppShareData.showAlert(title: kAlertTitle.localize, message: kErrorMessage, view: self)
        })
    }
}

////In App Purchase
//extension SubscriptionViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
//
//
//    func fetchProduct(){
//
//        let request = SKProductsRequest(productIdentifiers: ["com.ios.MuscleUp_silverPlan"])
//        request.delegate = self
//        request.start()
//
//    }
//
//
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions{
//            switch transaction.transactionState {
//            case .purchasing:
//                print(transaction)
//                print("Purchasing")
//                break
//            case .purchased, .restored:
//            print(".purchased, .restored")
//            print(transaction)
//                SKPaymentQueue.default().finishTransaction(transaction)
//                SKPaymentQueue.default().remove(self)
//                break
//            case .failed, .deferred:
//                print(transaction)
//                print(".failed, .deferred")
//                SKPaymentQueue.default().finishTransaction(transaction)
//                SKPaymentQueue.default().remove(self)
//            break
//            default:
//                SKPaymentQueue.default().finishTransaction(transaction)
//                SKPaymentQueue.default().remove(self)
//                break
//            }
//        }
//    }
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        if let product = response.products.first {
//            myProduct = product
//            print(product.productIdentifier)
//            print(product.price)
//            print(product.localizedTitle)
//            print(product.localizedDescription)
//        }
//    }
//
//
//}
