//
//  SubscriptionService.swift
//  Dovies
//
//  Created by Mindiii on 1/16/19.
//  Copyright © 2019 Hidden Brains. All rights reserved.
//

import UIKit
import StoreKit

let sharedobjec = SubscriptionService.shared

class SubscriptionService : NSObject , SKProductsRequestDelegate{
  
    
    var product: SKProduct?
    var productsArray = Array<SKProduct>()

    static let shared = SubscriptionService()

    func loadSubscriptionOptions() {
        
    //    com.wolfscore.Lifetime19.99
   //     com.wolfscore.autoRenewalOneYear10.99
  //    com.wolfscore.autoRenewalThreeMonth0.99

        let ThreeMonth = "com.mindiii.Bang.1MonthSubscription"
       // let OneYear = "com.wolfscore.autoRenewalOneYear10.99"
       // let Lifetime = "com.wolfscore.Lifetime19.99"

        
       let productIDs = Set([ThreeMonth])
        
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest , didReceive response: SKProductsResponse) {
        
        
        
         response.products.forEach { product in
            
            print("--------------------XXXX------------------------")
           
            if #available(iOS 11.2, *) {
                print("IntroductoryPrice:  \(String(describing: product.introductoryPrice?.price))")
            } else {
                // Fallback on earlier versions
            }
           
            print("ProductIdentifier:  \(product.productIdentifier)")
            print("localizedTitle: \(product.localizedTitle)")
            print("localizedDescription: \(product.localizedDescription)")
            if #available(iOS 11.2, *) {
                print("SubscriptionPeriod: \(String(describing: product.subscriptionPeriod))")
            } else {
                // Fallback on earlier versions
            }
            print("AccessibilityActivate: \(product.accessibilityActivate)")
            print("Pricelocal: \(product.priceLocale)")
            print("Price: \(product.price)")
            print("AccessiblityPoint: \(product.accessibilityActivationPoint)")
            print("AccessibilityCustomRotors: \(String(describing: product.accessibilityCustomRotors))")
            print("debugDescription: \(product.debugDescription)")
        }
        
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKProductsRequest {
            print("Subscription Options Failed Loading: \(error.localizedDescription)")
        }
    }
    
    private func loadReceipt() -> Data? {
        guard let url = Bundle.main.appStoreReceiptURL else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error loading receipt data: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions(withApplicationUsername: "")
    }

}


