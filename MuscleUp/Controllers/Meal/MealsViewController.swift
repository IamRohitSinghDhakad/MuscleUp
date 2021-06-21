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
