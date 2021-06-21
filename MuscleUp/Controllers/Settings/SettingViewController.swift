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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")as! PrivacyPolicyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
