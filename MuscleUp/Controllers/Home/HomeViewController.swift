//
//  HomeViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 19/06/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var cvCategories: UICollectionView!
    @IBOutlet var imgVwFooter: UIImageView!
    @IBOutlet var vwContainImgFooter: UIView!
    @IBOutlet var hgtConsCvCategories: NSLayoutConstraint!
    @IBOutlet var cvTrainer: UICollectionView!
    
    var arrCategory = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cvCategories.delegate = self
        self.cvCategories.dataSource = self
        
        self.cvTrainer.delegate = self
        self.cvTrainer.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBtnOpenSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.hgtConsCvCategories?.constant = self.cvCategories.contentSize.height
    }
    
}


extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvTrainer{
            return 3
        }else{
            return 6//self.arrCategory.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.cvTrainer{
            let cellTrainer = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell", for: indexPath)as! TrainerCollectionViewCell
                
                
                return cellTrainer
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)as! HomeCollectionViewCell
                
    //           let objCategory = self.arrCategory[indexPath.row]
    //
    //            cell.lblTitle.text = objCategory.strCategoryName
    //
    //            let profilePic = objCategory.strCategoryImage
    //
    //            if profilePic != "" {
    //                let url = URL(string: profilePic)
    //                cell.imgvwCategory.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }
                
                
                return cell
          
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.cvTrainer{
            let noOfCellsInRow = 1

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: 350)
        }else{
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size + 15)
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.viewWillLayoutSubviews()
 //   }
}
