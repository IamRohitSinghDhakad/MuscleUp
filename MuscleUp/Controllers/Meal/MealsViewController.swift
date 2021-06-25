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
    
     
    
    var arrMeals = ["BreakFast Meal","Snack Meal", "Lunch Meal", "Dinner Meal"]
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
        
        cell.lblMeals.text = self.arrMeals[indexPath.row]
        cell.imgVwMeal.image = self.arrMealsImage[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MealsDetailViewController")as! MealsDetailViewController
        
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
        
       // objWebServiceManager.showIndicator()
        
        let dict = ["sex":"Male"]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_getMeals, params: dict, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let category_data  = response["result"] as? [[String:Any]] {
                    if category_data.count != 0{
                        
//                        for data in category_data{
//                            let obj = CategoryModel.init(dict: data)
//                            self.arrCategory.append(obj)
//                        }
//                        
//                        self.cvCategories.reloadData()
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



