//
//  PurchaseHelper.swift
//  Dovies
//
//  Created by Companyname.
//  Copyright © Companyname. All rights reserved.
//

import UIKit

//This class used to perform purchase actions
class PurchaseHelper {
    
    static  var successHelper : ((_ purchaseProductDetials : PurchaseDetails, _ receiptData : String ,_ receipt_Data : Data  )->())!
    
    class func payForPackage(packageId: String, onSuccss : @escaping (_ purchaseProductDetials : PurchaseDetails,_ receiptData : String , _ receipt_Data : Data  )->(), onFail: @escaping (_ alertToShow : UIAlertController)->()){
        successHelper = onSuccss
        SwiftyStoreKit.purchaseProduct(packageId, atomically: false) { result in
            if case .success(let purchase) = result {
                
                //   UserDefaults.standard.set(packageId, forKey: UserDefaultsKey.iosPackageId)
                
                if purchase.needsFinishTransaction {
                    
                    SwiftyStoreKit.fetchReceipt(forceRefresh: false) { result in
                        switch result {
                        case .success(let receiptData):
                            
                            let encryptedReceipt = receiptData.base64EncodedString(options: [])
                            
                            //   UserDefaults.standard.set("purchased", forKey: UserDefaultsKey.productPurchased)
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                            
                            // Arvind- If we send puchase = yes and receipt = no last time then call api to send receipt to our server ragading previously purchased plan.
                            
                            onSuccss(purchase, encryptedReceipt ,receiptData)
                            print("Fetch receipt success:\n\(encryptedReceipt)")
                        case .error(let error):
                            print("Fetch receipt failed: \(error)")
                        }
                    }
                }
            }
            
            if let alert = self.alertForPurchaseResult(result) {
                onFail(alert)
            }
        }
    }
    
    class private func alertWithTitle(_ title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    class private func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController? {
        switch result {
        case .success(let purchase):
            print("Purchase Success: \(purchase.productId)")
            //            successHelper(purchase)
            return nil
        case .error(let error):
            print("Purchase Failed: \(error)")
            
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: error.localizedDescription)
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
            case .paymentCancelled: // user cancelled the request, etc.
                return alertWithTitle("Purchase Cancelled", message: "Your transaction was cancelled and you have not been charged.")
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked")
            case .privacyAcknowledgementRequired:
                return alertWithTitle("Purchase failed" , message: "Privacy acknowledgement required")
            case .unauthorizedRequestData:
                return alertWithTitle("Purchase failed", message: "Unauthorized request data")
            case .invalidOfferIdentifier:
                return alertWithTitle("Purchase failed", message: "Invalid offer Identifier")
            case .invalidSignature:
                return alertWithTitle("Purchase failed", message: "Invalid Signature")
            case .missingOfferParams:
                return alertWithTitle("Purchase failed", message: "Missing offer params")
                
            default:
                return alertWithTitle("Failed", message: "Default")
            }
        }
    }
}
