//
//  SettingViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var tblSettings: UITableView!
    
    var arrOptions = ["About Us","Privacy Policy","My Subscriptions","Contact Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblSettings.delegate = self
        self.tblSettings.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
   

    @IBAction func btnOnOpenSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
}



extension SettingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell")as! SettingTableViewCell
        
        cell.lblTitle.text = self.arrOptions[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // self.pushVc(viewConterlerId: "SubscriptionViewController")
        
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")as! PrivacyPolicyViewController
            vc.strType = self.arrOptions[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")as! PrivacyPolicyViewController
            vc.strType = self.arrOptions[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")as! PrivacyPolicyViewController
            vc.strType = self.arrOptions[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController")as! SubscriptionViewController
            vc.isComingFrom = "Setting"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
}
