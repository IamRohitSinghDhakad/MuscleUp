//
//  MealsViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class MealsViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tblMealPlan: UITableView!
    
    var arrMeals = [MealModel]()
    var arrMealsImage = [UIImage.init(named: "one_meal"), UIImage.init(named: "two_meal"), UIImage.init(named: "three_meal"),UIImage.init(named: "four_meal")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblMealPlan.delegate = self
        self.tblMealPlan.dataSource = self
        
        self.call_WsGetMeals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBgColor()
    }
    
    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
    
}

extension MealsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  self.arrMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealsTableViewCell")as! MealsTableViewCell
        
        let obj = self.arrMeals[indexPath.row]
        
        cell.lblMeals.text = obj.strMeal_plan_name
        
        let profilePic = obj.strMeal_plan_image
        if profilePic != "" {
            let url = URL(string: profilePic)
            cell.imgVwMeal.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "one_meal"))
        }else{
            cell.imgVwMeal.image = #imageLiteral(resourceName: "two_meal")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MealsDetailViewController")as! MealsDetailViewController
        vc.strMealId = self.arrMeals[indexPath.row].strMeal_plan_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

//MARK:- Call Webservice Get Meals List

extension MealsViewController{
    
    func call_WsGetMeals(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
    
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getMealsPlan, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let category_data  = response["result"] as? [[String:Any]] {
                    if category_data.count != 0{
                        
                        for data in category_data{
                            let obj = MealModel.init(dict: data)
                            self.arrMeals.append(obj)
                        }
                        
                        self.tblMealPlan.reloadData()
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



