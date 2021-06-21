//
//  AppDelegate.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 18/06/21.
//

import UIKit
import IQKeyboardManagerSwift

let ObjAppdelegate = UIApplication.shared.delegate as! AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    
    private static var AppDelegateManager: AppDelegate = {
        let manager = UIApplication.shared.delegate as! AppDelegate
        return manager
    }()
    // MARK: - Accessors
    class func AppDelegateObject() -> AppDelegate {
        return AppDelegateManager
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }

}
