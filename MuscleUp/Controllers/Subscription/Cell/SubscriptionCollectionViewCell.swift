//
//  SubscriptionCollectionViewCell.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class SubscriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tblSubscriptionList: UITableView!
    @IBOutlet var vwContainer: UIView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblValidity: UILabel!
    @IBOutlet var vwBg: UIView!
    @IBOutlet var btnChoose: UIButton!
    
    override func awakeFromNib() {
        
        self.tblSubscriptionList.delegate = self
        self.tblSubscriptionList.dataSource = self
        
        DispatchQueue.main.async {
            // corner radius
            self.vwContainer.layer.cornerRadius = 15
            // shadow
            self.vwContainer.layer.shadowColor = UIColor.lightGray.cgColor
            self.vwContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.vwContainer.layer.shadowOpacity = 0.9
            self.vwContainer.layer.shadowRadius = 5.0
        }
    }
}


extension SubscriptionCollectionViewCell:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionListTableViewCell")as! SubscriptionListTableViewCell
        
        cell.lblTitle.text = "Loream Ipsum dummy text"
        
        return cell
    }
    
    
}
